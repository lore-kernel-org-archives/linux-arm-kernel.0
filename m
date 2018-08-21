From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 21 Aug 2018 11:50:43 +0530
Subject: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <2e997c62-371c-1d9d-97ab-65726f588ab5@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
 <2e997c62-371c-1d9d-97ab-65726f588ab5@linux.ibm.com>
Message-ID: <dbd74447-b3e2-6bcf-2d8b-717b403bdf11@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Song,

On 08/21/2018 10:53 AM, Ravi Bangoria wrote:
> Hi Song,
> 
>> However, if I start a.out AFTER enabling the uprobe, there is something wrong:
>>
>> root at virt-test:~# ~/a.out
>> 11
>> semaphore 0       <<< this should be non-zero, as the uprobe is already enabled

In this testcase, semaphore variable is stored into .bss:

  $ nm test | grep semaphore
  0000000010010c5e B semaphore
 
  $ readelf -SW ./test | grep "data\|bss"
    [22] .data             PROGBITS        0000000010010c58 000c58 000004 00  WA  0   0  1
    [23] .bss              NOBITS          0000000010010c5c 000c5c 000004 00  WA  0   0  2

I'm not so sure but I guess .bss data initialization happens after
calling uprobe_mmap() and thus you are seeing semaphore as 0.

To verify this, if I force to save semaphore into data section by
assigning non-zero value to it:

  volatile short semaphore = 1

 $ nm test | grep semaphore
 0000000010010c5c D semaphore

 $ readelf -SW ./test | grep "data\|bss"
    [22] .data             PROGBITS        0000000010010c58 000c58 000006 00  WA  0   0  2
    [23] .bss              NOBITS          0000000010010c5e 000c5e 000002 00  WA  0   0  1 

increment/decrement works fine.

Ravi
