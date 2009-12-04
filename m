From: Joerg.Wagner@nw.neclab.eu (Joerg Wagner)
Date: Fri, 4 Dec 2009 13:26:46 +0100
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <4B18F141.7070101@denx.de>
References: <4B18F141.7070101@denx.de>
Message-ID: <50A01DCBF4001B478A524C12CAA7EF4D0FFBCC@VENUS.office>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Could you elaborate what you are expecting to see?
You are "read-modify-write"'ing a shared location without using atomic instructions, so it seems reasonable that the updates of the entry->in_msg are not behaving like you want them to behave.

Joerg

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Heiko Schocher
> Sent: Freitag, 4. Dezember 2009 12:24
> To: linux-arm-kernel at lists.infradead.org
> Subject: shared memory problem on ARM v5TE using threads
> 
> Hello,
> 
> I have the following shared mem problem on a ARM v5TE
> processor using Linux version 2.6.28,
> 
> -bash-3.2# cat /proc/cpuinfo
> Processor       : Feroceon 88FR131 rev 1 (v5l)
> BogoMIPS        : 799.53
> Features        : swp half thumb fastmult edsp
> CPU implementer : 0x56
> CPU architecture: 5TE
> CPU variant     : 0x2
> CPU part        : 0x131
> CPU revision    : 1
> 
> The testscript [1] starts 2 processes. One write
> process with one thread, which writes in a shared memory.
> 
> The second process starts 4 threads, which all read from
> this shared memory. This don;t work on this processor [4].
> The same demoprogramm works fine on ppc, i386 or on a
> ARMv6 based board [3][6] ...
> 
> If I start 4 read processes, which themselves starts only
> one readthread [5], the demoprogramm works fine!
> 
> Also, if I start one read process, which only attaches
> the shared memory once with shmat(), and then starts 4
> read threads, and all this 4 read threads using
> the same shared memory addr, returned from shmat(),
> this works as expected.
> 
> Any ideas, hints ... ?
> 
> TIA
> 
> bye,
> Heiko
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> 
> 
> [1] Testscript
> 
> #!/bin/sh
> echo "Compile"
> gcc -o shmtest2 shmtest2.c -lpthread
> 
> echo "Run shmtest2"
> ./shmtest2 write 1 &
> ./shmtest2 read 4 &
> 
> 
> [2] demoprogramm, shmtest2.c
> 
> #include <pthread.h>
> #include <sys/types.h>
> #include <sys/ipc.h>
> #include <sys/shm.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <string.h>
> 
> extern void      exit();
> 
> struct Entry
> {
>  char          ident_name[1000];
>  unsigned int  tipc_nr;
>  unsigned int  pid;
>  unsigned int  in_msg;
>  unsigned int  out_msg;
>  unsigned int  rxQueueLength;
> };
> 
> void* attachSharedMem(int shmid)
> {
>   void* addr = shmat(shmid, NULL, 0);
>   if ((addr != 0) && (0xffffffff != (unsigned int)addr))
>   {
>     printf("attach shared mem:%x\n",addr);
>   }
>   else
>   {
>     printf("shmat failed");
>     addr = 0;
>   }
>   return addr;
> }
> 
> int createSharedMem()
> {
>   key_t   key     = 1000;          /* key to be passed to shmget() */
>   int     shmflg;                  /* shmflg to be passed to shmget()
> */
>   int     shmid;                   /* return value from shmget() */
>   int     size;                    /* size to be passed to shmget() */
> 
>   size   = 60000;
>   shmflg = IPC_CREAT | 0666;
>   if ((shmid = shmget (key, size, shmflg)) == -1)
>   {
>     printf("shmget failed");
>     shmid = 0;
>   }
> 
>   printf("Shared memory Id:%d\n",shmid);
> 
>   return shmid;
> }
> 
> 
> void* setupSharedMem()
> {
>   int shmid = createSharedMem();
>   void* addrShm = attachSharedMem(shmid);
>   return addrShm;
> }
> 
> void *readThread(void *t)
> {
>   struct Entry* entry   = 0;
> 
>   int shmid = (int)t;
>   void* addrShm = attachSharedMem(shmid);
> 
>   if (addrShm != 0)
>   {
>     printf("Start Read Thread addr:%x\n",addrShm);
>     entry = (struct Entry*)addrShm;
>     entry->in_msg  = 0;
>     entry->out_msg = 0;
> 
>     int i=0;
>     while(i < 60)
>     {
>       entry->in_msg += 1000;
>       sleep(1);
>       printf("Read from entry in_msg=%d, out_msg=%d, addr=%x\n",entry-
> >in_msg,entry->out_msg, addrShm);
>       i++;
>     }
>   }
> 
>   pthread_exit(NULL);
> }
> 
> void *writeThread(void *t)
> {
>   struct Entry* entry   = 0;
>   unsigned int threadId = (unsigned int)t;
>   void* addrShm         = setupSharedMem();
> 
>   if (addrShm != 0)
>   {
>     printf("Start Write Thread %d, addr:%x\n",threadId,addrShm);
>     entry = (struct Entry*)addrShm;
>     strcpy(entry->ident_name,"this is a test entry");
>     entry->in_msg  = 0;
>     entry->out_msg = 0;
>     entry->rxQueueLength = 20000;
>     entry->pid     = threadId;
>     entry->tipc_nr = 1000;
> 
>     int i=0;
>     while(i < 60)
>     {
>       entry->out_msg += 1000;
>       sleep(1);
>       i++;
>     }
>   }
> 
>   pthread_exit(NULL);
> }
> 
> main(int argc, char* argv[])
> {
> 
>     //check the arguments
>     if (argc != 3)
>     {
>        printf("Arguments are [read|write] [number of threads]\n");
>        exit(1);
>     }
> 
>     unsigned int mode         = 0;
>     unsigned int nbrOfThreads = 0;
> 
>     if (strcmp(argv[1],"write") == 0)
>     {
>       printf("Write to in_msg\n");
>       mode = 1;
>     }
> 
>     if (strcmp(argv[1],"read") == 0)
>     {
>       printf("Read from in_msg\n");
>       mode = 2;
>     }
> 
>     nbrOfThreads = atoi(argv[2]);
> 
>     pthread_t threads[nbrOfThreads];
>     pthread_attr_t attr;
> 
>     /* Initialize and set thread detached attribute */
>     pthread_attr_init(&attr);
>     pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
> 
>     unsigned int t;
>     int rc;
>     for(t=0; t<nbrOfThreads; t++)
>     {
>       printf("Creating thread %ld\n", t);
>       if (mode == 1)
>       {
>         rc = pthread_create(&threads[t], &attr, writeThread, (void
> *)t);
>       }
>       else
>       {
>         int shmid = createSharedMem(t);
>         rc = pthread_create(&threads[t], &attr, readThread, (void
> *)shmid);
>       }
> 
>       if (rc)
>       {
>         printf("ERROR; return code from pthread_create() is %d\n", rc);
>         exit(-1);
>       }
>     }
> 
>     void* status;
>     pthread_attr_destroy(&attr);
>     for(t=0; t<nbrOfThreads; t++)
>     {
>       pthread_join(threads[t], &status);
>     }
> 
>     printf("All %s threads finished, exit\n",mode == 1 ?
> "write":"read");
> 
>     exit(0);
> }
> 
> [3] ARMv6 processor cpuinfo
> -bash-3.2# cat /proc/version
> Linux version 2.6.32-rc6 (dzu at pollux.denx.de) (gcc version 4.2.2) #4
> Thu Dec 3 12:31:13 CET 2009
> -bash-3.2# cat /proc/cpuinfo
> Processor       : ARMv6-compatible processor rev 4 (v6l)
> BogoMIPS        : 398.13
> Features        : swp half thumb fastmult vfp edsp java
> CPU implementer : 0x41
> CPU architecture: 6TEJ
> CPU variant     : 0x0
> CPU part        : 0xb36
> CPU revision    : 4
> 
> [4] Log from Demoprogramm, not working
> 
> -bash-3.2# ./shtest2.sh
> Run shmtest2
> Read from in_msg
> Creating thread 0
> Shared memory Id:0
> attach shared mem:40961000
> Start Read Thread addr:40961000
> Write to in_msg
> Creating thread 0
> Shared memory Id:0
> attach shared mem:40961000
> Start Write Thread 0, addr:40961000
> 348: write new mesg: 0
> Read from in_msg
> Creating thread 0
> Shared memory Id:0
> attach shared mem:40961000
> Start Read Thread addr:40961000
> Creating thread 1
> Shared memory Id:0
> Read from in_msg
> Creating thread 0
> Shared memory Id:0
> attach shared mem:40961000
> Start Read Thread addr:40961000
> attach shared mem:41170000
> Start Read Thread addr:41170000
> Read from in_msg
> Creating thread 0
> Shared memory Id:0
> attach shared mem:40961000
> Start Read Thread addr:40961000
> -bash-3.2# Read from entry in_msg=1000, out_msg=0, addr=40961000
> Read from entry in_msg=0, out_msg=0, addr=40961000
> Read from entry in_msg=2000, out_msg=1000, addr=40961000
> Read from entry in_msg=1000, out_msg=0, addr=41170000
> Read from entry in_msg=3000, out_msg=1000, addr=40961000
> Read from entry in_msg=4000, out_msg=1000, addr=40961000
> Read from entry in_msg=2000, out_msg=0, addr=40961000
> Read from entry in_msg=5000, out_msg=2000, addr=40961000
> Read from entry in_msg=3000, out_msg=0, addr=41170000
> Read from entry in_msg=6000, out_msg=2000, addr=40961000
> Read from entry in_msg=7000, out_msg=2000, addr=40961000
> Read from entry in_msg=4000, out_msg=0, addr=40961000
> Read from entry in_msg=8000, out_msg=3000, addr=40961000
> Read from entry in_msg=5000, out_msg=0, addr=41170000
> Read from entry in_msg=9000, out_msg=3000, addr=40961000
> Read from entry in_msg=10000, out_msg=3000, addr=40961000
> [...]
> 
> [5] Testscript which starts 4 read processes each with
>     one read thread
> 
> #!/bin/sh
> echo "Compile"
> gcc -o shmtest2 shmtest2.c -lpthread
> 
> echo "Run shmtest2"
> ./shmtest2 write 1 &
> ./shmtest2 read 1 &
> ./shmtest2 read 1 &
> ./shmtest2 read 1 &
> ./shmtest2 read 1 &
> 
> [6] working log on ARMv6
> 
> -bash-3.2# ./shtest2.sh
> Run shmtest2
> Write to in_msg
> Creating thread 0
> Shared memory Id:0
> attach shared mem:40960000
> Start Write Thread 0, addr:40960000
> Read from in_msg
> Creating thread 0
> Shared memory Id:0
> attach shared mem:40960000
> Start Read Thread addr:40960000
> Creating thread 1
> Shared memory Id:0
> Creating thread 2
> Shared memory Id:0
> Creating thread 3
> Shared memory Id:0
> attach shared mem:4216f000
> Start Read Thread addr:4216f000
> attach shared mem:4217e000
> Start Read Thread addr:4217e000
> attach shared mem:4218d000
> Start Read Thread addr:4218d000
> -bash-3.2# Read from entry in_msg=1000, out_msg=1000, addr=40960000
> Read from entry in_msg=2000, out_msg=1000, addr=4216f000
> Read from entry in_msg=3000, out_msg=1000, addr=4217e000
> Read from entry in_msg=4000, out_msg=1000, addr=4218d000
> Read from entry in_msg=5000, out_msg=2000, addr=40960000
> Read from entry in_msg=6000, out_msg=2000, addr=4216f000
> Read from entry in_msg=7000, out_msg=2000, addr=4217e000
> Read from entry in_msg=8000, out_msg=2000, addr=4218d000
> Read from entry in_msg=9000, out_msg=3000, addr=40960000
> Read from entry in_msg=10000, out_msg=3000, addr=4216f000
> Read from entry in_msg=11000, out_msg=3000, addr=4217e000
> Read from entry in_msg=12000, out_msg=3000, addr=4218d000
> Read from entry in_msg=13000, out_msg=4000, addr=40960000
> Read from entry in_msg=14000, out_msg=4000, addr=4216f000
> Read from entry in_msg=15000, out_msg=4000, addr=4217e000
> Read from entry in_msg=16000, out_msg=4000, addr=4218d000
> [...]
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
