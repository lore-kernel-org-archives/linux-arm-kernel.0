From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Oct 2017 10:23:07 +0100
Subject: [bug report & help] arm64: ltp testcase "migrate_pages01" failed
In-Reply-To: <59E571ED.9090106@huawei.com>
References: <59E49B2B.8020802@huawei.com>
 <59E571ED.9090106@huawei.com>
Message-ID: <20171017092307.GB21398@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 10:58:53AM +0800, Tan Xiaojun wrote:
> I'm not sure if this is the problem on arm64 numa. What do you think ?
> By the way, this testcase can be successful in any case on x86.

To be honest, this isn't a particularly helpful bug report. I appreciate
that a test is reporting failure, but it doesn't look like you've spent
very much effort to understand what the test is trying to do and why it
thinks it's failed to do it. All I can sensibly do with your bug report
is run the test myself, and it passes on the systems I have available.

So, you need to:

1. Understand what the test is doing.
2. Figure out which bit isn't doing what it's supposed to
3. See if that part can be isolated to trigger the problem

At that point, it should be possible to describe the unexpected behaviour
at a level which we can actually investigate if necessary.

Will

> On 2017/10/16 19:42, Tan Xiaojun wrote:
> > Hi all,
> > 
> > I test ltp in Hisilicon D05 board and get a failed result about the testcase "migrate_pages01".
> > 
> > In fact, The sub testcase "test_invalid_nodes" failed. The testcase is to find a invalid numa node and migrate memory pages to this node via syscall of "migrate_pages".
> > The expected result of this case is returning "-1", but it actually return "0".
> > 
> > --------------------------------------------------------
> > # ./migrate_pages01
> > migrate_pages01    0  TINFO  :  test_empty_mask
> > migrate_pages01    1  TPASS  :  expected ret success: returned value = 0
> > migrate_pages01    0  TINFO  :  test_invalid_pid -1
> > migrate_pages01    2  TPASS  :  expected ret success: returned value = -1
> > migrate_pages01    3  TPASS  :  expected failure: TEST_ERRNO=ESRCH(3): No such process
> > migrate_pages01    0  TINFO  :  test_invalid_pid unused pid
> > migrate_pages01    4  TPASS  :  expected ret success: returned value = -1
> > migrate_pages01    5  TPASS  :  expected failure: TEST_ERRNO=ESRCH(3): No such process
> > migrate_pages01    0  TINFO  :  test_invalid_masksize
> > migrate_pages01    6  TPASS  :  expected ret success: returned value = -1
> > migrate_pages01    7  TPASS  :  expected failure: TEST_ERRNO=EINVAL(22): Invalid argument
> > migrate_pages01    0  TINFO  :  test_invalid_mem -1
> > migrate_pages01    8  TPASS  :  expected ret success: returned value = -1
> > migrate_pages01    9  TPASS  :  expected failure: TEST_ERRNO=EFAULT(14): Bad address
> > migrate_pages01    0  TINFO  :  test_invalid_mem invalid prot
> > migrate_pages01   10  TPASS  :  expected ret success: returned value = -1
> > migrate_pages01   11  TPASS  :  expected failure: TEST_ERRNO=EFAULT(14): Bad address
> > migrate_pages01    0  TINFO  :  test_invalid_mem unmmaped
> > migrate_pages01   12  TPASS  :  expected ret success: returned value = -1
> > migrate_pages01   13  TPASS  :  expected failure: TEST_ERRNO=EFAULT(14): Bad address
> > migrate_pages01    0  TINFO  :  test_invalid_nodes
> > migrate_pages01   14  TFAIL  :  migrate_pages_common.c:45: unexpected failure - returned value = 0, expected: -1
> > migrate_pages01   15  TFAIL  :  migrate_pages_common.c:55: call succeeded unexpectedly
> > migrate_pages01    0  TINFO  :  test_invalid_perm
> > migrate_pages01   16  TPASS  :  expected ret success: returned value = -1
> > migrate_pages01   17  TPASS  :  expected failure: TEST_ERRNO=EPERM(1): Operation not permitted
> > --------------------------------------------------------
> > 
> > I debug and find a interesting thing, this case does not always fail.
> > 
> > 1) If one or several numa nodes have no memory, this case will run successfully like below:
> > 
> > --------------------
> > available: 4 nodes (0-3)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
> > node 0 size: 65309 MB
> > node 0 free: 61650 MB
> > node 1 cpus: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> > node 1 size: 65404 MB
> > node 1 free: 61377 MB
> > node 2 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
> > node 2 size: 65401 MB
> > node 2 free: 62316 MB
> > node 3 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
> > node 3 size: 0 MB
> > node 3 free: 0 MB
> > node distances:
> > node   0   1   2   3
> >   0:  10  15  20  20
> >   1:  15  10  20  20
> >   2:  20  20  10  15
> >   3:  20  20  15  10
> > ---------------------
> > 
> > This testcase will find node number 3 and migrate pages to node 3. And syscall of "migrate_pages" return -1, test succeeded.
> > 
> > 2) In most cases, all nodes have memory, and the testcase will get non-existent node like node number 4. The syscall of "migrate_pages" should also return -1, but return 0 actually.
> > So the testcase failed.
> > 
> > I think it is a problem in arm64. But I am not familiar with numa, so I ask for help from you.
> > 
> > Thanks.
> > Xiaojun.
> > 
> > 
> > .
> > 
> 
> 
