From: ccross@android.com (Colin Cross)
Date: Fri, 25 May 2012 13:04:22 -0700
Subject: [PATCH v2] RFC: ARM: cache-l2x0: update workaround for PL310
 errata 727915
In-Reply-To: <20120525145603.GG13467@mudshark.cambridge.arm.com>
References: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
 <CAMQu2gy3VTtQhnVVvzgYGhr_vA=vnW=rSBW17yoBTNwkN3wHqQ@mail.gmail.com>
 <20120522085256.GA7286@mudshark.cambridge.arm.com>
 <4FBB5AE8.4000801@ti.com>
 <20120522093410.GC7286@mudshark.cambridge.arm.com>
 <CAMbhsRSJADaXBEpFr2Mk3xm0-c2brYiDUAcY8u1rzP-XwycfBA@mail.gmail.com>
 <20120525145603.GG13467@mudshark.cambridge.arm.com>
Message-ID: <CAMbhsRS_RtuvkrOh1nJ=cdYDgfM0tY9MivnbuWDcS_+NcW0qjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 7:56 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, May 22, 2012 at 07:36:23PM +0100, Colin Cross wrote:
>> I was using an omap 4430, triggering l2x0_clean_all from a GPU ioctl
>> by calling outer_clean_range(0, ULONG_MAX). ?The problem was very
>> reproducible at the time, and using the persistent_trace code I posted
>> a while back I was able to narrow it down to hanging the cpu (not an
>> infinite loop) inside cache_wait_way. ?It was 100% reproducible just
>> booting a development version of Android, but not if I called
>> l2x0_clean_all during boot, so it may depend on cache state or load.
>
> Right, ok. This is definitely a different problem though. Firstly, r3p1 is
> not affected by the original erratum and secondly the symptoms do not
> include deadlock. The clean during boot also sounds highly suspicious -- is
> there a chance you boot the kernel with a dirty L2? Is the L2 enabled or
> disabled when entering the kernel [I think u8500 has it enabled]?

In a previous thread, I wrote that the 4430 I was using had r2p0.  I
can't verify the accuracy of that claim right now, but my patch was
based on that assumption.  Where are you getting r3p1 from?

When I said I couldn't reproduce the issue with clean during boot, I
meant that I couldn't trigger the issue during boot by calling clean
repeatedly.  I could still reproduce the issue after boot even if the
cache was cleaned during boot.

The reference to 727915 came from discussions with TI, but given that
it is a deadlock and not a memory corruption, you're probably right
that it is not the same issue.
