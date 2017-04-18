From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 18 Apr 2017 21:01:52 +0100
Subject: [PATCH] fs: Preventing READ_IMPLIES_EXEC Propagation
In-Reply-To: <20170418170118.GH27592@e104818-lin.cambridge.arm.com>
References: <1492088223-98232-1-git-send-email-zhangshaokun@hisilicon.com>
 <2414e3b3-03f6-bd6c-5aa4-ad58c66b5aa5@huawei.com>
 <20170418170118.GH27592@e104818-lin.cambridge.arm.com>
Message-ID: <CAFEAcA_wH1dDbcjEEBaLX0q8pfWsfYUGGL-zOC4MuxySqa=uvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2017 at 18:01, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Apr 13, 2017 at 08:33:52PM +0800, dongbo (E) wrote:
>> From: Dong Bo <dongbo4@huawei.com>
>>
>> In load_elf_binary(), once the READ_IMPLIES_EXEC flag is set,
>> the flag is propagated to its child processes, even the elf
>> files are marked as not requiring executable stack. It may
>> cause superfluous operations on some arch, e.g.
>> __sync_icache_dcache on aarch64 due to a PROT_READ mmap is
>> also marked as PROT_EXEC.

> That's affecting most architectures with a risk of ABI breakage. We
> could do it on arm64 only, though I'm not yet clear on the ABI
> implications (at a first look, there shouldn't be any).

Is there a reason why it isn't just straightforwardly a bug
(which we could fix) to make READ_IMPLIES_EXEC propagate to
child processes? AFAICT this should be per-process: just because
init happens not to have been (re)compiled to permit non-executable
stacks doesn't mean every process on the system needs to have
an executable stack. Behaviour shouldn't be variable across
architectures either, I would hope.

thanks
-- PMM
