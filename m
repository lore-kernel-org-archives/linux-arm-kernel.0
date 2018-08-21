From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 21 Aug 2018 17:28:26 +0530
Subject: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <1534836620.dp1nz6tfz0.naveen@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
 <1534836620.dp1nz6tfz0.naveen@linux.ibm.com>
Message-ID: <4445e941-551e-881f-c519-db82ed9b9b5c@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/21/2018 01:04 PM, Naveen N. Rao wrote:
> Song Liu wrote:
>> I am testing the patch set with the following code:
>>
>> #include <stdio.h>
>> #include <unistd.h>
>>
>> volatile short semaphore = 0;
>>
>> int for_uprobe(int c)
>> {
>> ??????? printf("%d\n", c + 10);
>> ??????? return c + 1;
>> }
>>
>> int main(int argc, char *argv[])
>> {
>> ??????? for_uprobe(argc);
>> ??????? while (1) {
>> ??????????????? sleep(1);
>> ??????????????? printf("semaphore %d\n", semaphore);
>> ??????? }
>> }
>>
>> I created a uprobe on function for_uprobe(), that uses semaphore as
>> reference counter:
>>
>> ? echo "p:uprobe_1 /root/a.out:0x49a(0x1036)" >> uprobe_events
> 
> Is that even valid? That _looks_ like a semaphore, but I'm not quite sure that it qualifies as an _SDT_ semaphore. Do you see this issue if you instead use the macros provided by <sys/sdt.h> to create SDT markers?
> 

Right. By default SDT reference counters(semaphore) goes into .probes
section:

  [25] .probes           PROGBITS        000000000060102c 00102c 000004 00  WA  0   0  2

which has PROGBITS set. So this works fine. And there are many other
things which are coded into <sys/sdt.h>. So the official way to use
SDT markers should be through that.

Ravi
