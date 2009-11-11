From: zentrale.at.work@gmail.com (Josef Holzmayr)
Date: Wed, 11 Nov 2009 13:44:46 +0100
Subject: atmel_serial losing characters under libmodbus
Message-ID: <4AFAB1BE.4040008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using libmodbus on an atmel_serial line, it seems to lose about 1 
char in 50 that it's supposed to receive. This is independet of the baud 
rate, it happens everywhere from 2400 to 19200. Full code excerpt from 
the lib is below, but basically reading is just an select/read pair. Are 
there some known issues with that particular tty device?

Greetz Joe

Opening (unabridged, only comments explaining termios removed):
static int modbus_connect_rtu(modbus_param_t *mb_param)
{
         struct termios tios;
         speed_t speed;

         if (mb_param->debug) {
                 printf("Opening %s at %d bauds (%s)\n",
                        mb_param->device, mb_param->baud, mb_param->parity);
         }

         mb_param->fd = open(mb_param->device, O_RDWR | O_NOCTTY | 
O_NDELAY);
         if (mb_param->fd < 0) {
                 perror("open");
                 printf("ERROR Can't open the device %s (errno %d)\n",
                        mb_param->device, errno);
                 return -1;
         }

         /* Save */
         tcgetattr(mb_param->fd, &(mb_param->old_tios));

         memset(&tios, 0, sizeof(struct termios));

         switch (mb_param->baud) {
         case 110:
                 speed = B110;
                 break;
         case 300:
                 speed = B300;
                 break;
         case 600:
                 speed = B600;
                 break;
         case 1200:
                 speed = B1200;
                 break;
         case 2400:
                 speed = B2400;
                 break;
         case 4800:
                 speed = B4800;
                 break;
         case 9600:
                 speed = B9600;
                 break;
         case 19200:
                 speed = B19200;
                 break;
         case 38400:
                 speed = B38400;
                 break;
         case 57600:
                 speed = B57600;
                 break;
         case 115200:
                 speed = B115200;
                 break;
         default:
                 speed = B9600;
                 printf("WARNING Unknown baud rate %d for %s (B9600 
used)\n",
                        mb_param->baud, mb_param->device);
         }


         if ((cfsetispeed(&tios, speed) < 0) ||
             (cfsetospeed(&tios, speed) < 0)) {
                 perror("cfsetispeed/cfsetospeed\n");
                 return -1;
         }

         tios.c_cflag |= (CREAD | CLOCAL);

         tios.c_cflag &= ~CSIZE;
         switch (mb_param->data_bit) {
         case 5:
                 tios.c_cflag |= CS5;
                 break;
         case 6:
                 tios.c_cflag |= CS6;
                 break;
         case 7:
                 tios.c_cflag |= CS7;
                 break;
         case 8:
         default:
                 tios.c_cflag |= CS8;
                 break;
         }

         /* Stop bit (1 or 2) */
         if (mb_param->stop_bit == 1)
                 tios.c_cflag &=~ CSTOPB;
         else /* 2 */
                 tios.c_cflag |= CSTOPB;

         if (strncmp(mb_param->parity, "none", 4) == 0) {
                 tios.c_cflag &=~ PARENB;
         } else if (strncmp(mb_param->parity, "even", 4) == 0) {
                 tios.c_cflag |= PARENB;
                 tios.c_cflag &=~ PARODD;
         } else {
                 /* odd */
                 tios.c_cflag |= PARENB;
                 tios.c_cflag |= PARODD;
         }

         tios.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG);

         if (strncmp(mb_param->parity, "none", 4) == 0) {
                 tios.c_iflag &= ~INPCK;
         } else {
                 tios.c_iflag |= INPCK;
         }

         tios.c_iflag &= ~(IXON | IXOFF | IXANY);

         tios.c_oflag &=~ OPOST;

         tios.c_cc[VMIN] = 0;
         tios.c_cc[VTIME] = 0;

         if (tcsetattr(mb_param->fd, TCSANOW, &tios) < 0) {
                 perror("tcsetattr\n");
                 return -1;
         }

         return 0;
}

Reading (basically just a select/read pair):
#define WAIT_DATA() \
{ \
     while ((select_ret = select(mb_param->fd+1, &rfds, NULL, NULL, 
&tv)) == -1) { \
             if (errno == EINTR) { \
                     printf("A non blocked signal was caught\n"); \
                     /* Necessary after an error */ \
                     FD_ZERO(&rfds); \
                     FD_SET(mb_param->fd, &rfds); \
             } else { \
                     error_treat(mb_param, SELECT_FAILURE, "Select 
failure"); \
                     return SELECT_FAILURE; \
             } \
     } \
     if (select_ret == 0) { \
             return COMM_TIME_OUT; \
     } \
}

/* Waits a reply from a modbus slave or a query from a modbus master.
    This function blocks for timeout seconds if there is no reply.

    In
    - msg_length_computed must be set to MSG_LENGTH_UNDEFINED if undefined

    Out
    - msg is an array of uint8_t to receive the message
    - p_msg_length, the variable is assigned to the number of
      characters received. This value won't be greater than
      msg_length_computed.

    Returns 0 in success or a negative value if an error occured.
*/
static int receive_msg(modbus_param_t *mb_param,
                        int msg_length_computed,
                        uint8_t *msg, int *p_msg_length)
{
         int select_ret;
         int read_ret;
         fd_set rfds;
         struct timeval tv;
         int length_to_read;
         uint8_t *p_msg;
         enum { FUNCTION, BYTE, COMPLETE };
         int state;

         if (mb_param->debug) {
                 if (msg_length_computed == MSG_LENGTH_UNDEFINED)
                         printf("Waiting for a message...\n");
                 else
                         printf("Waiting for a message (%d bytes)...\n",
                                msg_length_computed);
         }

         /* Add a file descriptor to the set */
         FD_ZERO(&rfds);
         FD_SET(mb_param->fd, &rfds);

         if (msg_length_computed == MSG_LENGTH_UNDEFINED) {
                 /* Wait for a message */
                 tv.tv_sec = 60;
                 tv.tv_usec = 0;

                 /* The message length is undefined (query receiving) so
                  * we need to analyse the message step by step.
                  * At the first step, we want to reach the function
                  * code because all packets have that information. */
                 msg_length_computed = mb_param->header_length + 2;
                 state = FUNCTION;
         } else {
                 tv.tv_sec = 0;
                 tv.tv_usec = TIME_OUT_BEGIN_OF_TRAME;
                 state = COMPLETE;
         }

         length_to_read = msg_length_computed;

         select_ret = 0;
         WAIT_DATA();

         /* Initialize the readin the message */
         (*p_msg_length) = 0;
         p_msg = msg;

         while (select_ret) {
                 if (mb_param->type_com == RTU)
                         read_ret = read(mb_param->fd, p_msg, 
length_to_read);
                 else
                         read_ret = recv(mb_param->fd, p_msg, 
length_to_read, 0);

                 if (read_ret == 0) {
                         printf("Connection closed\n");
                         return CONNECTION_CLOSED;
                 } else if (read_ret < 0) {
                         /* The only negative possible value is -1 */
                         error_treat(mb_param, PORT_SOCKET_FAILURE,
                                     "Read port/socket failure");
                         return PORT_SOCKET_FAILURE;
                 }

                 /* Sums bytes received */
                 (*p_msg_length) += read_ret;

                 /* Display the hex code of each character received */
                 if (mb_param->debug) {
                         int i;
                         for (i=0; i < read_ret; i++)
                                 printf("<%.2X>", p_msg[i]);
                 }

                 if ((*p_msg_length) < msg_length_computed) {
                         /* Message incomplete */
                         length_to_read = msg_length_computed - 
(*p_msg_length);
                 } else {
                         switch (state) {
                         case FUNCTION:
                                 /* Function code position */
                                 length_to_read = 
compute_query_length_header(msg[mb_param->header_length + 1]);
                                 msg_length_computed += length_to_read;
                                 /* It's useless to check
                                    p_msg_length_computed value in this
                                    case (only defined values are used). */
                                 state = BYTE;
                                 break;
                         case BYTE:
                                 length_to_read = 
compute_query_length_data(mb_param, msg);
                                 msg_length_computed += length_to_read;
                                 if (msg_length_computed > 
MAX_MESSAGE_LENGTH) {
                                      error_treat(mb_param, 
TOO_MANY_DATA, "Too many data");
                                      return TOO_MANY_DATA;
                                 }
                                 state = COMPLETE;
                                 break;
                         case COMPLETE:
                                 length_to_read = 0;
                                 break;
                         }
                 }

                 /* Moves the pointer to receive other data */
                 p_msg = &(p_msg[read_ret]);

                 if (length_to_read > 0) {
                         /* If no character at the buffer wait
                            TIME_OUT_END_OF_TRAME before to generate an 
error. */
                         tv.tv_sec = 0;
                         tv.tv_usec = TIME_OUT_END_OF_TRAME;

                         WAIT_DATA();
                 } else {
                         /* All chars are received */
                         select_ret = FALSE;
                 }
         }

         if (mb_param->debug)
                 printf("\n");

         if (mb_param->type_com == RTU) {
                 check_crc16(mb_param, msg, (*p_msg_length));
         }

         /* OK */
         return 0;
}

-- 
Josef"ZaP" Holzmayr

"Never underestimate the bandwidth of a freight train full of DAT tapes. 
Just latency might be an issue"
