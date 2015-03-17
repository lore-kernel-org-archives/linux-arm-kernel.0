From: Andrew.Pinski@caviumnetworks.com (Pinski, Andrew)
Date: Tue, 17 Mar 2015 17:07:07 +0000
Subject: Question about aarch64 ILP32 ABI changes
In-Reply-To: <55029CC6.2050306@huawei.com>
References: <55029CC6.2050306@huawei.com>
Message-ID: <CY1PR0701MB124480C7DEE49D7A85D553189E030@CY1PR0701MB1244.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My answers below.  Note I am using a stupid mail client for this reply which does not do proper quoting.

-----Original Message-----
From: Bamvor Jian Zhang [mailto:bamvor.zhangjian at huawei.com] 
Sent: Friday, March 13, 2015 1:16 AM
To: Catalin Marinas; Andrew Pinski
Cc: linux-arm-kernel at lists.infradead.org; hongjiu.lu at intel.com; Bintian; Dingtianhong; zhangjian
Subject: Question about aarch64 ILP32 ABI changes


Hi,

I am testing Andrew ILP32 patches[ilp32 v3 patch] through LTP testsuite.
Most of the testcases are passed. Some testcases are failed because of LTP issue while the other testcases are failed because ILP32 ABI is difference from arm 32bit.

So, how should we deal with it? It would be fixed in kernel/glibc or in application. Fix it in application may hurt the ABI compatabilities.

[Andrew] See https://sourceware.org/ml/libc-alpha/2015-03/msg00572.html which is the same report of this bug.
[Andrew]
[Andrew] Thanks,
[Andrew] Andrew Pinski

1.  ABI changes in msgrcv and msgsnd
    In current ILP32 ABI, msgsnd and msgrcv is 64bit syscall. I guess it is because the msgctl must be 64bit syscall after time_t is defined as 64bit. This will lead to the issue when application define the msgbuf struct. Such struct usually defined out of glibc and kernel, because application may need the difference size of msgbuf.mtext.

    If the msgsnd and msgrcv remain 64bit syscall, the header in application may like this:

```
    #ifdef __ILP32
        typedef long long _mtype;
    #else
        typedef long _mtype;
    #endif
    typedef struct mbuf {          /* a generic message structure */
        _mtype mtype;
        char mtext[MSGSIZE + 1];  /* add 1 here so the message can be 1024   */
    } MSGBUF;                        /* characters long with a '\0' termination */
```

    Compare with above change in application, there is another way to sovle this issue: map msgsnd and msgrcv to compat syscall (base on Andrew patch [ilp32 syscall table]).

```
    diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
    index 8c68d28..00d4f65 100644
    --- a/arch/arm64/kernel/sys_ilp32.c
    +++ b/arch/arm64/kernel/sys_ilp32.c
    @@ -132,6 +132,11 @@ asmlinkage long ilp32_sys_mq_notify(mqd_t mqdes,
      */
     #define sys_mq_notify          ilp32_sys_mq_notify

    +/*
    + * msgsnd, msgrcv
    + */
    +#define sys_msgrcv              compat_sys_msgrcv
    +#define sys_msgsnd              compat_sys_msgsnd

     /*
      * sigaltstack needs some special handling as the ```

    From our perspective, life may be earier if the code of applcation is same between ilp32 and arm 32bit.

2.  ABI changes around off_t.
    Current ILP32 abi define off_t as 64bit long which make only one register is needed when pass offset from userspace to kernel. At the same time, it lead to some corner case failure, e.g. ftest02. It failed bacause the compiler treat the negative number as 32bit integer while the off_t is 64bit integer which make the kernel treat the 32bit negative integer as 64bit position integer.

    This will be ok if force a cast in application code:
```
    diff --git a/testcases/kernel/fs/ftest/ftest02.c b/testcases/kernel/fs/ftest/ftest02.c
    index 35cc0d8..472887e 100644
    --- a/testcases/kernel/fs/ftest/ftest02.c
    +++ b/testcases/kernel/fs/ftest/ftest02.c
    @@ -269,7 +269,7 @@ static void crfile(int me, int count)
            val = write(fd, crmsg, sizeof(crmsg) - 1);
            warn(val, "write", 0);

    -       val = lseek(fd, -(sizeof(crmsg) - 1), 1);
    +       val = lseek(fd, -(off_t)(sizeof(crmsg) - 1), 1);
            warn(val, "lseek", 0);

            val = read(fd, buf, sizeof(crmsg) - 1); ```

cc'd H J Lu, I appreciate some suggestions if x32 encounter the similar issue.

BTW, six month past after previous round review, is there any plan about when will the community would like to ack these series patches?

regards

bamvor

[ilp32 v3 patch] (https://lkml.org/lkml/2014/9/3/704)
[ilp32 syscall table] (https://lkml.org/lkml/2014/9/3/725)
