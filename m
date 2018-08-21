From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Tue, 21 Aug 2018 10:12:13 +0530
Subject: [PATCH v9 0/4] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <CAPhsuW70nRkwM8C76m4c_XF4tjepdRWYezg15sTvkMUDtHZ8JQ@mail.gmail.com>
Message-ID: <b0b9e181-0df7-dc8f-927a-a2cf52bed93d@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Song,

> root at virt-test:~# ~/a.out
> 11
> semaphore 0
> semaphore 0
> semaphore 2      <<<  when the uprobe is enabled

Yes, this happens when multiple vmas points to the same file portion.
Can you check /proc/`pgrep a.out`/maps.

Logic is simple. If we are going to patch an instruction, increment the
reference counter. If we are going to unpatch an instruction, decrement
the reference counter. In this case, we patched instruction twice and
thus incremented reference counter twice as well.

Ravi
