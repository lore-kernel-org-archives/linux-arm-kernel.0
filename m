From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2012 17:10:09 +0000
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
References: <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
 <yw1x1uqlnw1o.fsf@unicorn.mansr.com>
 <20120127132826.GD2347@mudshark.cambridge.arm.com>
 <CACVXFVPHpmPX9OdeYzzWjQ-qqs=9oYbL_og-_xJA2ypYNu0nRA@mail.gmail.com>
 <CAMsRxfJOAh1V7sMWxqCXADDB_eSAuxop1iYAGqXvLC_74Pfz1A@mail.gmail.com>
 <20120127155454.GH2347@mudshark.cambridge.arm.com>
 <CAMsRxfK-SFEyP5+jyXDyWSQPJ2KO_1YQM_yZdtwV0NJu+idqHA@mail.gmail.com>
 <20120127165941.GK2347@mudshark.cambridge.arm.com>
 <CAMsRxf+iv06zOCMzhYONeLaf6RvOLp38T53mR--8ESHvCXMeFQ@mail.gmail.com>
Message-ID: <20120127171009.GL2347@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 05:03:28PM +0000, stephane eranian wrote:
> On Fri, Jan 27, 2012 at 5:59 PM, Will Deacon <will.deacon@arm.com> wrote:
> > That said, if you see any bugs in the code please do shout!
> >
> I suspect there is something wrong, we shouldn't hit the max_rate_limit.
> You may have bursts of interrupts (samples). I'll check on that this week-end.

Ok, thanks. Keep in mind that you probably have variable rate clocks, which
will affect the cycle counter frequency.

> >> > A7 and A15 have the ability to filter counters based on privilege level, so
> >> > you can get more accurate userspace counts there.
> >>
> >> Ok, that's better. Need to update libpfm4 for A15 with priv levels then!
> >
> > How do you handle that in libpfm4? On ARM, the event encodings remain the same,
> > you just need to set some extra bits to determine which levels are included or
> > excluded (you can do this with the perf tool by using the :{u,k,h} suffix on an
> > event description).
> >
> It depends what you call the encoding? If the priv level can be encoded in the
> attr->config field, then that's easy. If it needs to be set somewhere else, then
> we need to figure out how you encode it in the attr struct. Either in some other
> bits in attr->config or use attr->config1, for instance. You tell me.

The way it's done with perf is to set the exclude{user,kernel,hv} fields in
the attr. The ARM perf backend then translates these into the relevant bits
which get orred into the config_base before hitting the hardware.

Will
