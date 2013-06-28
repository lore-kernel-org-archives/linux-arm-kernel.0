From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 28 Jun 2013 12:25:44 +0200
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <20130627151318.GB1360@darko.cambridge.arm.com>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
 <20130626111430.GH26142@mudshark.cambridge.arm.com>
 <CAKv+Gu_R7=Euaa87kQqR5TfGQLyF6Ad51dBm2CroYHcKMRs_dA@mail.gmail.com>
 <20130626124009.GL26142@mudshark.cambridge.arm.com>
 <CAKv+Gu9_V75jGSq675H+Gi7jkDWBkVDLXvewMuv8dWxx7-VxEw@mail.gmail.com>
 <CAKv+Gu-5SsvJCvXkJoqPm-TZx6tr+49pUXfpkSoBo-s+Z8_YmQ@mail.gmail.com>
 <CAKv+Gu_=Ctg8+KVMp9amq+2nOgj8DiUKidNDwas8qy2=y3TX-A@mail.gmail.com>
 <20130627151318.GB1360@darko.cambridge.arm.com>
Message-ID: <CAKv+Gu8wsXCDO-7FCJG+Rbkkyahm563UX2dMDXVstYhjAZ+TrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2013 17:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Jun 27, 2013 at 02:11:27PM +0100, Ard Biesheuvel wrote:
>> OK, just one more question before I respin the next (hopefully final) version:
>> if a caller does sleep after calling kernel_neon_begin() (and thus
>> receives no warning if he runs a non-PREEMPT build with
>> CONFIG_DEBUG_ATOMIC_SLEEP disabled), he will most likely find the
>> NEON/VFP unit disabled after waking up (as we disable it on a context
>> switch), so any subsequent NEON instructions will trigger the undef
>> handler.
>
> Can you check on the VFP context switch path whether kernel_neon_begin()
> has been called and we are moving away from the task? You could even
> store the LR in kernel_neon_begin() to give better error information.
>

I wil take this suggestion for the arm64 case, and propose a new
version next week. For arm, I think we should be ok without this, as
Will also suggested, because you will always hit the BUG() in
vfp_kmode_exception() if you touch the NEON from the kernel after a
context switch (there are only two ways to get the NEON enabled, one
is through lazy restore, which now only works from userland, and the
other is through kernel_neon_begin())

-- 
Ard.
