From: hs@denx.de (Heiko Schocher)
Date: Fri, 04 Dec 2009 14:42:12 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091204131307.GE15887@n2100.arm.linux.org.uk>
References: <4B18F141.7070101@denx.de>
	<20091204131307.GE15887@n2100.arm.linux.org.uk>
Message-ID: <4B1911B4.7080907@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell King,

Russell King - ARM Linux wrote:
> On Fri, Dec 04, 2009 at 12:23:45PM +0100, Heiko Schocher wrote:
>> [4] Log from Demoprogramm, not working
> 
> I think this is messed up - this is not from your first script but your
> second script which starts four independent read processes.
> 
> I determined this because:
> (1) the read thread addresses are mostly the same
> (2) there are four "Read form in_msg" strings, which you only print
> once at the start of the program.

Ups, sorry for the confusion, here 2 logs with the right values:

-bash-3.2# cat shtest2.sh
#!/bin/sh
echo "Run shmtest2"
./shmtest2 write 1 &
./shmtest2 read 4 &

-bash-3.2# cat shmtest2.c
#include <pthread.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

extern void      exit();

struct Entry
{
 char          ident_name[1000];
 unsigned int  tipc_nr;
 unsigned int  pid;
 unsigned int  in_msg;
 unsigned int  out_msg;
 unsigned int  rxQueueLength;
};

void* attachSharedMem(int shmid)
{
  void* addr = shmat(shmid, NULL, 0);
  if ((addr != 0) && (0xffffffff != (unsigned int)addr))
  {
    printf("attach shared mem:%x\n",addr);
  }
  else
  {
    printf("shmat failed");
    addr = 0;
  }
  return addr;
}

int createSharedMem()
{
  key_t   key     = 1000;          /* key to be passed to shmget() */
  int     shmflg;                  /* shmflg to be passed to shmget() */
  int     shmid;                   /* return value from shmget() */
  int     size;                    /* size to be passed to shmget() */

  size   = 60000;
  shmflg = IPC_CREAT | 0666;
  if ((shmid = shmget (key, size, shmflg)) == -1)
  {
    printf("shmget failed");
    shmid = 0;
  }

  printf("Shared memory Id:%d\n",shmid);

  return shmid;
}


void* setupSharedMem()
{
  int shmid = createSharedMem();
  void* addrShm = attachSharedMem(shmid);
  return addrShm;
}

void *readThread(void *t)
{
  struct Entry* entry   = 0;

  int shmid = (int)t;
  void* addrShm = attachSharedMem(shmid);

  if (addrShm != 0)
  {
    printf("Start Read Thread addr:%x\n",addrShm);
    entry = (struct Entry*)addrShm;
    entry->in_msg  = 0;
    entry->out_msg = 0;

    int i=0;
    while(i < 60)
    {
      entry->in_msg += 1000;
      sleep(1);
      printf("%d Read from entry in_msg=%d, out_msg=%d, addr=%x\n", getpid(), entry->in_msg,entry->out_msg, addrShm);
      i++;
    }
  }

  pthread_exit(NULL);
}

void *writeThread(void *t)
{
  struct Entry* entry   = 0;
  unsigned int threadId = (unsigned int)t;
  void* addrShm         = setupSharedMem();

  if (addrShm != 0)
  {
    printf("Start Write Thread %d, addr:%x\n",threadId,addrShm);
    entry = (struct Entry*)addrShm;
    strcpy(entry->ident_name,"this is a test entry");
    entry->in_msg  = 0;
    entry->out_msg = 0;
    entry->rxQueueLength = 20000;
    entry->pid     = threadId;
    entry->tipc_nr = 1000;

    int i=0;
    while(i < 60)
    {
        printf("%d: write new mesg: %d\n", getpid(), entry->out_msg);
      entry->out_msg += 1000;
      sleep(1);
      //printf("Write in entry with threadId=%d\n", threadId);
      i++;
    }
  }

  pthread_exit(NULL);
}

main(int argc, char* argv[])
{

    //check the arguments
    if (argc != 3)
    {
       printf("Arguments are [read|write] [number of threads]\n");
       exit(1);
    }

    unsigned int mode         = 0;
    unsigned int nbrOfThreads = 0;

    if (strcmp(argv[1],"write") == 0)
    {
      printf("Write to in_msg\n");
      mode = 1;
    }

    if (strcmp(argv[1],"read") == 0)
    {
      printf("Read from in_msg\n");
      mode = 2;
    }

    nbrOfThreads = atoi(argv[2]);

    pthread_t threads[nbrOfThreads];
    pthread_attr_t attr;

    /* Initialize and set thread detached attribute */
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    unsigned int t;
    int rc;
    for(t=0; t<nbrOfThreads; t++)
    {
      printf("Creating thread %ld\n", t);
      if (mode == 1)
      {
        rc = pthread_create(&threads[t], &attr, writeThread, (void *)t);
      }
      else
      {
        int shmid = createSharedMem(t);
        rc = pthread_create(&threads[t], &attr, readThread, (void *)shmid);
      }

      if (rc)
      {
        printf("ERROR; return code from pthread_create() is %d\n", rc);
        exit(-1);
      }
    }

    void* status;
    pthread_attr_destroy(&attr);
    for(t=0; t<nbrOfThreads; t++)
    {
      pthread_join(threads[t], &status);
    }

    printf("All %s threads finished, exit\n",mode == 1 ? "write":"read");

    exit(0);
}

-bash-3.2# ./shtest2.sh
Run shmtest2
Write to in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Write Thread 0, addr:40961000
411: write new mesg: 0
Read from in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Read Thread addr:40961000
Creating thread 1
Shared memory Id:0
attach shared mem:41170000
Start Read Thread addr:41170000
Creating thread 2
Shared memory Id:0
attach shared mem:4197f000
Start Read Thread addr:4197f000
Creating thread 3
Shared memory Id:0
attach shared mem:4218e000
Start Read Thread addr:4218e000
-bash-3.2# 411: write new mesg: 0
413 Read from entry in_msg=1000, out_msg=0, addr=40961000
413 Read from entry in_msg=2000, out_msg=0, addr=41170000
413 Read from entry in_msg=3000, out_msg=0, addr=4197f000
413 Read from entry in_msg=4000, out_msg=0, addr=4218e000
411: write new mesg: 1000
413 Read from entry in_msg=1000, out_msg=1000, addr=40961000
413 Read from entry in_msg=2000, out_msg=1000, addr=41170000
413 Read from entry in_msg=3000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=4000, out_msg=1000, addr=4218e000
411: write new mesg: 2000
413 Read from entry in_msg=5000, out_msg=1000, addr=40961000
413 Read from entry in_msg=6000, out_msg=1000, addr=41170000
413 Read from entry in_msg=7000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=8000, out_msg=1000, addr=4218e000
411: write new mesg: 3000
413 Read from entry in_msg=9000, out_msg=1000, addr=40961000
413 Read from entry in_msg=10000, out_msg=1000, addr=41170000
413 Read from entry in_msg=11000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=12000, out_msg=1000, addr=4218e000
411: write new mesg: 4000
413 Read from entry in_msg=13000, out_msg=1000, addr=40961000
413 Read from entry in_msg=14000, out_msg=1000, addr=41170000
413 Read from entry in_msg=15000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=16000, out_msg=1000, addr=4218e000
411: write new mesg: 5000
413 Read from entry in_msg=17000, out_msg=1000, addr=40961000
413 Read from entry in_msg=18000, out_msg=1000, addr=41170000
413 Read from entry in_msg=19000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=20000, out_msg=1000, addr=4218e000
411: write new mesg: 6000
413 Read from entry in_msg=21000, out_msg=1000, addr=40961000
413 Read from entry in_msg=22000, out_msg=1000, addr=41170000
413 Read from entry in_msg=23000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=24000, out_msg=1000, addr=4218e000
411: write new mesg: 7000
413 Read from entry in_msg=25000, out_msg=1000, addr=40961000
413 Read from entry in_msg=26000, out_msg=1000, addr=41170000
413 Read from entry in_msg=27000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=28000, out_msg=1000, addr=4218e000
411: write new mesg: 8000
413 Read from entry in_msg=29000, out_msg=1000, addr=40961000
413 Read from entry in_msg=30000, out_msg=1000, addr=41170000
413 Read from entry in_msg=31000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=32000, out_msg=1000, addr=4218e000
411: write new mesg: 9000
413 Read from entry in_msg=33000, out_msg=1000, addr=40961000
413 Read from entry in_msg=34000, out_msg=1000, addr=41170000
413 Read from entry in_msg=35000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=36000, out_msg=1000, addr=4218e000
411: write new mesg: 10000
413 Read from entry in_msg=37000, out_msg=1000, addr=40961000
413 Read from entry in_msg=38000, out_msg=1000, addr=41170000
413 Read from entry in_msg=39000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=40000, out_msg=1000, addr=4218e000
411: write new mesg: 11000
413 Read from entry in_msg=41000, out_msg=1000, addr=40961000
413 Read from entry in_msg=42000, out_msg=1000, addr=41170000
413 Read from entry in_msg=43000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=44000, out_msg=1000, addr=4218e000
411: write new mesg: 12000
413 Read from entry in_msg=45000, out_msg=1000, addr=40961000
413 Read from entry in_msg=46000, out_msg=1000, addr=41170000
413 Read from entry in_msg=47000, out_msg=1000, addr=4197f000
413 Read from entry in_msg=48000, out_msg=1000, addr=4218e000
411: write new mesg: 13000

-bash-3.2# cat shtest2.sh
#!/bin/sh
echo "Run shmtest2"
./shmtest2 write 1 &
./shmtest2 read 1 &
./shmtest2 read 1 &
./shmtest2 read 1 &
./shmtest2 read 1 &

-bash-3.2# ./shtest2.sh
Run shmtest2
Write to in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Write Thread 0, addr:40961000
423: write new mesg: 0
Read from in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Read Thread addr:40961000
Read from in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Read Thread addr:40961000
Read from in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Read Thread addr:40961000
Read from in_msg
Creating thread 0
Shared memory Id:0
attach shared mem:40961000
Start Read Thread addr:40961000
-bash-3.2# 423: write new mesg: 0
425 Read from entry in_msg=1000, out_msg=1000, addr=40961000
427 Read from entry in_msg=2000, out_msg=1000, addr=40961000
429 Read from entry in_msg=3000, out_msg=1000, addr=40961000
431 Read from entry in_msg=4000, out_msg=1000, addr=40961000
423: write new mesg: 1000
425 Read from entry in_msg=5000, out_msg=2000, addr=40961000
427 Read from entry in_msg=6000, out_msg=2000, addr=40961000
429 Read from entry in_msg=7000, out_msg=2000, addr=40961000
431 Read from entry in_msg=8000, out_msg=2000, addr=40961000
423: write new mesg: 2000
425 Read from entry in_msg=9000, out_msg=3000, addr=40961000
427 Read from entry in_msg=10000, out_msg=3000, addr=40961000
429 Read from entry in_msg=11000, out_msg=3000, addr=40961000
431 Read from entry in_msg=12000, out_msg=3000, addr=40961000
423: write new mesg: 3000
425 Read from entry in_msg=13000, out_msg=4000, addr=40961000
427 Read from entry in_msg=14000, out_msg=4000, addr=40961000
429 Read from entry in_msg=15000, out_msg=4000, addr=40961000
431 Read from entry in_msg=16000, out_msg=4000, addr=40961000
423: write new mesg: 4000
425 Read from entry in_msg=17000, out_msg=5000, addr=40961000
427 Read from entry in_msg=18000, out_msg=5000, addr=40961000
429 Read from entry in_msg=19000, out_msg=5000, addr=40961000
431 Read from entry in_msg=20000, out_msg=5000, addr=40961000
423: write new mesg: 5000
425 Read from entry in_msg=21000, out_msg=6000, addr=40961000
427 Read from entry in_msg=22000, out_msg=6000, addr=40961000
429 Read from entry in_msg=23000, out_msg=6000, addr=40961000
431 Read from entry in_msg=24000, out_msg=6000, addr=40961000
423: write new mesg: 6000
425 Read from entry in_msg=25000, out_msg=7000, addr=40961000
427 Read from entry in_msg=26000, out_msg=7000, addr=40961000
429 Read from entry in_msg=27000, out_msg=7000, addr=40961000
431 Read from entry in_msg=28000, out_msg=7000, addr=40961000
423: write new mesg: 7000
425 Read from entry in_msg=29000, out_msg=8000, addr=40961000
427 Read from entry in_msg=30000, out_msg=8000, addr=40961000
429 Read from entry in_msg=31000, out_msg=8000, addr=40961000
431 Read from entry in_msg=32000, out_msg=8000, addr=40961000
423: write new mesg: 8000
425 Read from entry in_msg=33000, out_msg=9000, addr=40961000
427 Read from entry in_msg=34000, out_msg=9000, addr=40961000
429 Read from entry in_msg=35000, out_msg=9000, addr=40961000
431 Read from entry in_msg=36000, out_msg=9000, addr=40961000

Thanks!

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
