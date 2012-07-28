From: gabriel.tisan@gmail.com (Gabriel Tisan)
Date: Sat, 28 Jul 2012 22:07:35 +0200
Subject: i2c: imx: could not read data
Message-ID: <CAD9ZU8BLrMbh684DN_Pyj0y-EtbvALKvtBUYUz+iVj00SNHstQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi !

I have the following environment :
- Kernel based on 3.2.21 with custom changes and with commit (bb79a07)
"i2c: imx: fix imx driver to work though signal is pending" applied
- board based on imx35 derived from Freescale i.MX35 3-stack eval board

I try to read some data from I2C by following userspace application,
but I get some error:
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#include <linux/i2c-dev.h>

int main() {
	int file, i;
	char filename[20];
	char buf[3];
	int adapter_nr = 0; /* I2C-0 */
	int addr = 0x08; /* The I2C address */	
  	char reg = 0x07; /* Device register to access */

	snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
	file = open(filename, O_RDWR);
	if (file < 0) {
		printf("%s: open failed: %s\n",file, strerror(errno));
		exit(1);
	}

	if (ioctl(file, I2C_SLAVE, addr) < 0) {
		printf("%s: set slave address failed: %s\n",file, strerror(errno));
		exit(1);
	}

	buf[0] = reg;
	buf[1] = 0;
	buf[2] = 0;
	if (write(file, buf, 1) != 1) {
		printf("%s: write failed: %s\n",file, strerror(errno));
		exit(1);
	}

	if (read(file, buf, 2) != 2) {
		printf("%s: read failed: %s\n",filename, strerror(errno));
		exit(1);
	} else {
	    printf("Read bytes\n");
		/* buf contains the ID bytes */
		printf("ID: ");
	 	for (i=0; i<2; i++) {
			printf("%02x ",buf[i]);
		}
	}	
	return 0;
}

Here is the debug log with the error that I get when i run the program
from above:
i2c i2c-0: ioctl, cmd=0x703, arg=0x08
i2c-dev: i2c-0 writing 1 bytes.
i2c i2c-0: master_xfer[0] W, addr=0x08, len=1
i2c i2c-0: <i2c_imx_xfer>
i2c i2c-0: <i2c_imx_start>
i2c i2c-0: <i2c_imx_bus_busy>
i2c i2c-0: <i2c_imx_xfer> transfer message: 0
i2c i2c-0: <i2c_imx_xfer> CONTROL: IEN=1, IIEN=1, MSTA=1, MTX=1, TXAK=1, RSTA=0
i2c i2c-0: <i2c_imx_xfer> STATUS: ICF=1, IAAS=0, IBB=1, IAL=0, SRW=0,
IIF=0, RXAK=1
i2c i2c-0: <i2c_imx_write> write slave address: addr=0x10
i2c i2c-0: <i2c_imx_trx_complete> TRX complete
i2c i2c-0: <i2c_imx_acked> ACK received
i2c i2c-0: <i2c_imx_write> write data
i2c i2c-0: <i2c_imx_write> write byte: B0=0x7
i2c i2c-0: <i2c_imx_trx_complete> TRX complete
i2c i2c-0: <i2c_imx_acked> ACK received
i2c i2c-0: <i2c_imx_stop>
i2c i2c-0: <i2c_imx_bus_busy>
i2c i2c-0: <i2c_imx_xfer> exit with: success msg: 1
i2c-dev: i2c-0 reading 2 bytes.
i2c i2c-0: master_xfer[0] R, addr=0x08, len=2
i2c i2c-0: <i2c_imx_xfer>
i2c i2c-0: <i2c_imx_start>
i2c i2c-0: <i2c_imx_bus_busy>
i2c i2c-0: <i2c_imx_xfer> transfer message: 0
i2c i2c-0: <i2c_imx_xfer> CONTROL: IEN=1, IIEN=1, MSTA=1, MTX=1, TXAK=1, RSTA=0
i2c i2c-0: <i2c_imx_xfer> STATUS: ICF=1, IAAS=0, IBB=1, IAL=0, SRW=0,
IIF=0, RXAK=1
i2c i2c-0: <i2c_imx_read> write slave address: addr=0x11
i2c i2c-0: <i2c_imx_trx_complete> TRX complete
i2c i2c-0: <i2c_imx_acked> No ACK
i2c i2c-0: <i2c_imx_stop>
i2c i2c-0: <i2c_imx_bus_busy>
i2c i2c-0: <i2c_imx_xfer> exit with: error: -5

Using i2ctools it seems that with i2c everything is fine:
# i2cdetect -l
i2c-0i2c       imx-i2c                         I2C adapter
i2c-1i2c       imx-i2c                         I2C adapter
i2c-2i2c       imx-i2c                         I2C adapter
# i2cdetect -y 0
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
# i2cget -y 0 0x08 07 w
0x4100

How you can see using i2ctools I can read without any errors from
register 07 of slave device 08 found on i2c-0.
On the same board using an old kernel 2.6.32.16 I can read data from
i2c-0 using my userspace app.

Has anybody some suggestions what could I try to go forward ?

Best regards,
Gabriel
