From: james.morse@arm.com (James Morse)
Date: Wed, 20 Jun 2018 11:06:33 +0100
Subject: [PATCH] arm64/mm: Introduce a variable to hold base address of
 linear region
In-Reply-To: <CACi5LpMXpSWUP97R2VWjf==LdxPBCKTcpKjQjCs4j3Kz9SzYGg@mail.gmail.com>
References: <CAKv+Gu8Hs+CArdkAWoBPbr_p-nq5+0oPwOPg0NsJDRMkE_bM9A@mail.gmail.com>
 <d801005a-5f7a-8fe4-a486-bc6443a406a3@arm.com>
 <CACi5LpOJ7Q7nbo9m_HGqr44+n_iEtreZt+Uxtf2PzcHSzTdKuA@mail.gmail.com>
 <3a05cd0e-466e-4fb6-a78a-4b363e21aaab@arm.com>
 <CACi5LpMJnFthKUJGfMWgDyMTM65oTtOvsRGCtMDjWP32qDptbQ@mail.gmail.com>
 <92ff5220-f863-4edc-bc9f-bd802d2efa9c@arm.com>
 <d5e01f4bedc649ff8a2ee17b17c1c33d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619085541.GB13984@arm.com>
 <6860c284f1c74faa95edd6cf866ec80d@HXTBJIDCEMVIW02.hxtcorp.net>
 <20180619094045.GD13984@arm.com>
 <a720d91be20844cd9ed84728268300d9@HXTBJIDCEMVIW02.hxtcorp.net>
 <09260c7e-8b9d-bc3c-5bca-0fd75417f552@arm.com>
 <CACi5LpMoKP4eG5XhYe5hf5VC9MOY8KuHK=j0ujb8GFpyjAuAww@mail.gmail.com>
 <b0d40351-8d78-fd69-cc87-d5ea5eaabd2a@arm.com>
 <CACi5LpM2GV-vwcEGeCE20QW0PVmDcKnjz017sYBAwYRfZ24AzA@mail.gmail.com>
 <51cf54d6a19f4837b74218b000cc23bc@HXTBJIDCEMVIW02.hxtcorp.net>
 <CACi5LpMXpSWUP97R2VWjf==LdxPBCKTcpKjQjCs4j3Kz9SzYGg@mail.gmail.com>
Message-ID: <aa9e1422-abbd-6d43-0a9f-eaf3476328a1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 20/06/18 08:26, Bhupesh Sharma wrote:
> On Wed, Jun 20, 2018 at 7:46 AM, Jin, Yanjiang
> <yanjiang.jin@hxt-semitech.com> wrote:
>> If /proc/kcore always exists in kexec/kdump, I think this issue can be fixed
>> easily. But it requires  that Kexec/kdump have to rely on " CONFIG_PROC_KCORE=y".
>> I am not sure if we can persuade Kexec-tools community to accept this.

For the kernel this would be:
--------------%<--------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 1aa59063f1fd..0ea2c7c0ac08 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -8,6 +8,7 @@ config CRASH_CORE

 config KEXEC_CORE
        select CRASH_CORE
+       select PROC_KCORE
        bool

 config HAVE_IMA_KEXEC
--------------%<--------------

With this kernel's that support kdump but don't have /proc/kcore wouldn't have
the new PT_NOTEs anyway. Whatever you do today is all you can do.


> Most distributions like Ubuntu and Fedora already enable
> CONFIG_PROC_KCORE by default, to support user-space tools like
> crash-utility and makedumpfile which can be used for 'live' debugging
> of a primary kernel (without the requirement of being in the secondary
> or crash kernel).
> 
> For such cases. '/proc/kcore' and 'vmlinux' are the only available
> sources for PT_NOTE/PT_LOAD segments and kernel symbols respectively.
> 
> Since we need to support all such existing user-space utilities (which
> work well with other archs like x86 and ppc64),

x86 has kaslr too, I couldn't work out how your user-space:phys_to_virt() works
there. Are we missing an alternative trick?


> we need to have a
> solution which works without modifying most of them - the rest (like
> kexec-tools) can be easily modified to follow the same approach.

(We're  also trying to solve this in a way that lets user-space shed
arch-specific code.)


Thanks,

James
