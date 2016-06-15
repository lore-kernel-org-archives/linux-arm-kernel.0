From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 15 Jun 2016 17:16:03 +0200
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <20160615150558.GB7971@leverpostej>
References: <1465923441-107596-1-git-send-email-glider@google.com>
 <20160614175543.GA2468@leverpostej>
 <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
 <20160615092509.GA3984@leverpostej> <20160615114438.GC3984@leverpostej>
 <CAG_fn=U7-fUnw1GLwBbmqGTxnOWf4QcTjTyP4mGAORfEuWt3Eg@mail.gmail.com>
 <20160615142550.GA7971@leverpostej>
 <CACT4Y+bqx9LyMxvnD-f6vs3MuTxQJkuPMirz4vfDe8NpfoTUHw@mail.gmail.com>
 <20160615150558.GB7971@leverpostej>
Message-ID: <CACT4Y+Z3=juvxBJBXRh5PgE35twFRxg-3iMc-owenONU84x5XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 5:05 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jun 15, 2016 at 04:36:18PM +0200, Dmitry Vyukov wrote:
>> > However, it looks like I missed a warning from the kernel build system,
>> > and my toolchain doesn't actually support -fsanitize-coverage=trace-pc,
>> > so I'm not going to be able to test that further.
>> >
>> > It would be great if we could deliberately not register the debugfs file
>> > when there was no compiler support for the feature, for those like me
>> > who miss the build time warning. We do something like that for the LSE
>> > atomics on arm64.
>>
>> Hi Mark,
>>
>> It's a common problem and it would be great to detect this.
>> But I think it's better to return ENOTSUP from open rather than not
>> registering the file at all. This way higher level tools will be able
>> to more easily diagnose the issue and properly report to user. A
>> missing file looks like not mounted debugfs (which another common
>> issue).
>
> I have no strong feeling either way, so long as we don't silently carry
> on in a case that makes no sense.
>
>> I am not sure how to do it.
>> Compiler does not provide any define for this option. And I am not
>> familiar enough with kernel makefiles. Would it be possible to add a
>> define to CLAGS in the makefile along with printing the warning?
>
> If you follow the arm64 LSE example, you can do something like the
> below.
>
> Note that this relies on CFLAGS_KCOV being cleared when not supported by
> the toolchain. I used ENOTSUPP rather than ENOTSUP as there's no
> standard definition for the later in the Linux headers.
>
> Mark.
>
> ---->8----
> diff --git a/Makefile b/Makefile
> index 0f70de6..e6ef260 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -369,7 +369,7 @@ LDFLAGS_MODULE  =
>  CFLAGS_KERNEL  =
>  AFLAGS_KERNEL  =
>  CFLAGS_GCOV    = -fprofile-arcs -ftest-coverage -fno-tree-loop-im -Wno-maybe-uninitialized
> -CFLAGS_KCOV    = -fsanitize-coverage=trace-pc
> +CFLAGS_KCOV    = -fsanitize-coverage=trace-pc -DCONFIG_KCOV_CC
>
>
>  # Use USERINCLUDE when you must reference the UAPI directories only.
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index a02f2dd..df2cafd 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -3,6 +3,7 @@
>  #define DISABLE_BRANCH_PROFILING
>  #include <linux/compiler.h>
>  #include <linux/types.h>
> +#include <linux/errno.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> @@ -160,6 +161,13 @@ static int kcov_open(struct inode *inode, struct file *filep)
>  {
>         struct kcov *kcov;
>
> +       /*
> +        * CONFIG_KCOV was selected, but the compiler does not support the
> +        * options KCOV requires.
> +        */
> +       if (!IS_ENABLED(CONFIG_KCOV_CC))
> +               return -ENOTSUPP;
> +
>         kcov = kzalloc(sizeof(*kcov), GFP_KERNEL);
>         if (!kcov)
>                 return -ENOMEM;


Looks great. Please mail it.
