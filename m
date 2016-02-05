From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Feb 2016 17:21:17 +0000
Subject: [PATCH v5sub2 1/8] arm64: add support for module PLTs
In-Reply-To: <CAKv+Gu-W_zKYEz0yKVevtO2b2A8+TEEXfX+iGG8PLcV7M63JYw@mail.gmail.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454332178-4414-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160204151303.GB6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9n=bmsZ=UOBiLWzaG2JSsbdC8k1mB7yFbH0czrbXS-1g@mail.gmail.com>
 <20160205154234.GF6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-poQiuc7+O38n93Xt2o-SYi3kYD0k_9+-6T0=FXV9uXA@mail.gmail.com>
 <20160205160054.GG6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8g7FHHZgmbFww_XZjf5J1utmigwBiNqCg8a3crfB4xFA@mail.gmail.com>
 <20160205164648.GH6076@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-W_zKYEz0yKVevtO2b2A8+TEEXfX+iGG8PLcV7M63JYw@mail.gmail.com>
Message-ID: <20160205172117.GI6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 05:54:46PM +0100, Ard Biesheuvel wrote:
> On 5 February 2016 at 17:46, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Feb 05, 2016 at 05:20:14PM +0100, Ard Biesheuvel wrote:
> >> On 5 February 2016 at 17:00, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > On Fri, Feb 05, 2016 at 04:53:10PM +0100, Ard Biesheuvel wrote:
> >> >> On 5 February 2016 at 16:42, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> >> > On Thu, Feb 04, 2016 at 04:31:59PM +0100, Ard Biesheuvel wrote:
> >> >> >> On 4 February 2016 at 16:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> >> >> > On Mon, Feb 01, 2016 at 02:09:31PM +0100, Ard Biesheuvel wrote:
> >> >> >> >> This adds support for emitting PLTs at module load time for relative
> >> >> >> >> branches that are out of range. This is a prerequisite for KASLR, which
> >> >> >> >> may place the kernel and the modules anywhere in the vmalloc area,
> >> >> >> >> making it more likely that branch target offsets exceed the maximum
> >> >> >> >> range of +/- 128 MB.
> >> >> >> >
> >> >> >> > Any downside to trying to keep the kernel+modules coupled together so
> >> >> >> > that we avoid the PLT?
> >> >> >>
> >> >> >> First of all, note that it is unlikely that the PLTs are ever required
> >> >> >> in practice, considering that either
> >> >> >> a) the kernel is loaded at the default location right at the base of
> >> >> >> the vmalloc range, and in this case, the module space is reserved for
> >> >> >> modules only, or
> >> >> >> b) the kernel is loaded at some random offset in the 240+ GB vmalloc
> >> >> >> space, and it is unlikely that all VMA space around the kernel happens
> >> >> >> to be given out to non-randomized vmalloc/ioremap allocations
> >> >> >
> >> >> > My worry is that we merge some code that's rarely tested.
> >> >>
> >> >> I understand. But unfortunately, having corner cases that are unlikely
> >> >> but not impossible comes with the territory of randomization.
> >> >>
> >> >> Alternatively, we could take the performance hit if KASLR is in effect
> >> >> and allocate each module completely randomly as well. This way, the
> >> >> code is always exercised (for now), and we can always backpedal later
> >> >> if the performance is measurably worse.
> >> >
> >> > I'm fine with this. You can post it as a separate patch that we can
> >> > easily revert/modify later (like turning it into a config option).
> >>
> >> OK, I will hack something up
> >
> > If it's simpler, you can just add a config option but defaulting to the
> > full vmalloc space for modules.
> 
> What would be the simplest is to randomize the 128 MB module region as
> a whole, and either put it close to the kernel (which is what I am
> doing now), or put it at a random offset inside the vmalloc space, in
> which case all branches will be resolved via PLTs. My suggestion to
> randomize each module_alloc() call separately is actually not that
> straight-forward.
> 
> So what I propose now is to keep a single module_load_offset that
> randomizes the base of the region, and add a default-n config option
> that shrinks the interval it is chosen from so that PLTs are usually
> not needed.

Sounds fine.

-- 
Catalin
