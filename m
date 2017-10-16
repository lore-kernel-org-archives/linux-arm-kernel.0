From: cj.chengjian@huawei.com (chengjian (D))
Date: Mon, 16 Oct 2017 12:27:17 +0800
Subject: A issue about ptrace/SINGLESTEP on arm64
Message-ID: <8ad32f6b-e04d-98f8-d944-7ec3582fbdf4@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
I write demo use ptrace/SINGLESTEP to count the number of instructions 
executed by the process
The parent process fork+exec a child process, and trace(SINGLESTEP) it,

It works fine under the x86_64 architecture but has an exception under 
arm64.

```cpp
//demo.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <unistd.h>

#ifdef DEBUG
#define dprintf printf
#else
#define dprintf 0 && printf
#endif


int main(int argc, char *argv[])
{
     long long counter = 0;
     int wait_val;
     int pid;

     puts("Please wait");

     switch (pid = fork()) {
     case -1:
         perror("fork");
         break;

     case 0:
         ptrace(PTRACE_TRACEME, 0, 0, 0);
         execl("/bin/ls", "ls", NULL);
         break;

     default:
         //ptrace(PTRACE_ATTACH, pid, NULL, NULL);
         //waitpid(pid, &wait_val, 0);
          //while (wait_val == 1407 ) {
          while ( 1 )
          {
             wait(&wait_val);
             if(WIFEXITED(&wait_val)) {
                 break;
             }
             counter++;
             if (ptrace(PTRACE_SINGLESTEP, pid, 0, 0) != 0)
                 perror("ptrace");
             else
             dprintf("counter = %lld\n", counter);
         }
     }

     printf("Number of machine instructions : %lld\n", counter);
     return 0;
}
```

It run for a long long time and seems never to stop.


./demo /bin/ls


     counter = 8033129
     counter = 8033130
     counter = 8033131
     counter = 8033132
     counter = 8033133
     counter = 8033134
     counter = 8033135
     counter = 8033136
     counter = 8033137
     counter = 8033138
     counter = 8033139
     ^C




It return the same results when track other the other C processes
And then I make an assembly demo(just print Hello-World),

It looks just all right

```asm
//hello.s
// as hello.s ?o hello.o
// ld hello.o ?o hello
.text //code section
.globl _start
_start:
     mov x0, 0     // stdout has file descriptor 0
     ldr x1, =msg  // buffer to write
     mov x2, len   // size of buffer
     mov x8, 64    // sys_write() is at index 64 in kernel functions table
     svc #0        // generate kernel call sys_write(stdout, msg, len);
     mov x0, 123 // exit code
     mov x8, 93  // sys_exit() is at index 93 in kernel functions table
     svc #0      // generate kernel call sys_exit(123);
.data //data section
msg:
     .ascii      "Hello, ARM!\n"
len = . - msg
```



./demo ./hello


     ./hello : hello

     Please wait
     Hello, ARM!
     Number of machine instructions : 8


I want to know what's going on about it, Is this a bug?
