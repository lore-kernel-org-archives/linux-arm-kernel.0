From: naveen.n.rao@linux.vnet.ibm.com (Naveen N. Rao)
Date: Tue, 21 Aug 2018 13:04:17 +0530
Subject: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
Message-ID: <1534836620.dp1nz6tfz0.naveen@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Song Liu wrote:
> I am testing the patch set with the following code:
> 
> #include <stdio.h>
> #include <unistd.h>
> 
> volatile short semaphore = 0;
> 
> int for_uprobe(int c)
> {
>         printf("%d\n", c + 10);
>         return c + 1;
> }
> 
> int main(int argc, char *argv[])
> {
>         for_uprobe(argc);
>         while (1) {
>                 sleep(1);
>                 printf("semaphore %d\n", semaphore);
>         }
> }
> 
> I created a uprobe on function for_uprobe(), that uses semaphore as
> reference counter:
> 
>   echo "p:uprobe_1 /root/a.out:0x49a(0x1036)" >> uprobe_events

Is that even valid? That _looks_ like a semaphore, but I'm not quite 
sure that it qualifies as an _SDT_ semaphore. Do you see this issue if 
you instead use the macros provided by <sys/sdt.h> to create SDT 
markers?


- Naveen
