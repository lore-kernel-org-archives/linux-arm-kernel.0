From: keescook@chromium.org (Kees Cook)
Date: Fri, 30 Sep 2016 11:42:02 -0700
Subject: [kernel-hardening] Re: [PATCH v3 0/7] arm64: Privileged Access
 Never using TTBR0_EL1 switching
In-Reply-To: <20160929224452.GA71670@samitolvanen.mtv.corp.google.com>
References: <1473788797-10879-1-git-send-email-catalin.marinas@arm.com>
 <20160915162044.GB19214@leverpostej>
 <20160929224452.GA71670@samitolvanen.mtv.corp.google.com>
Message-ID: <CAGXu5jKEpZgc9zqmX=QKs_NH70fX_4CRNEtFKXEETK6UwykNMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 3:44 PM, Sami Tolvanen <samitolvanen@google.com> wrote:
> On Thu, Sep 15, 2016 at 05:20:45PM +0100, Mark Rutland wrote:
>> Likewise, how do we handle __flush_cache_user_range and
>> flush_icache_range? Some callers (e.g. __do_compat_cache_op) pass in
>> __user addresses.
>
> Also EXEC_USERSPACE in lkdtm passes a user space address to flush_icache_range
> and causes the process to hang when I tested these patches on HiKey.
>
> Adding uaccess_{enable,disable}_not_uao to __flush_cache_user_range appears to
> fix the problem.

I had a thought just now on this: is lkdtm maybe doing the wrong thing
here? i.e. should lkdtm be the one do to the uaccess_en/disable
instead of flush_icache_range() itself, since it's the one abusing the
API?

-Kees

-- 
Kees Cook
Nexus Security
