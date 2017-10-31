From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Oct 2017 13:51:24 +0000
Subject: [PATCH v2 2/8] arm: KVM: Add optimized PIPT icache flushing
In-Reply-To: <20171021151817.GE12618@cbox>
References: <20171020154904.31427-1-marc.zyngier@arm.com>
 <20171020154904.31427-3-marc.zyngier@arm.com>
 <20171020162711.2mb2wyw5xqfhkc4o@lakrids.cambridge.arm.com>
 <d0dd031b-976f-0a77-9b63-8807aa8f9b4b@arm.com>
 <20171020165440.sdqfdyt6jsmbjcx5@lakrids.cambridge.arm.com>
 <20171021151817.GE12618@cbox>
Message-ID: <20171031135123.mkqxxzsmmf346t4r@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 21, 2017 at 05:18:17PM +0200, Christoffer Dall wrote:
> On Fri, Oct 20, 2017 at 05:54:40PM +0100, Mark Rutland wrote:
> > On Fri, Oct 20, 2017 at 05:53:39PM +0100, Marc Zyngier wrote:
> > > On 20/10/17 17:27, Mark Rutland wrote:
> > > > On Fri, Oct 20, 2017 at 04:48:58PM +0100, Marc Zyngier wrote:
> > > >> @@ -181,18 +185,40 @@ static inline void __invalidate_icache_guest_page(struct kvm_vcpu *vcpu,

> > > >> +		do {
> > > >> +			write_sysreg(addr, ICIMVAU);
> > > >> +			addr += iclsz;
> > > >> +		} while (addr < end);
> > > >> +
> > > >> +		dsb(ishst);
> > > > 
> > > > I believe this needs to be ISH rather than ISHST.
> > > > 
> > > > Per, ARM DDI 0487B.b, page G3-4701, "G3.4 AArch32 cache and branch
> > > > predictor support":
> > > > 
> > > >     A DSB or DMB instruction intended to ensure the completion of cache
> > > >     maintenance instructions or branch predictor instructions must have
> > > >     an access type of both loads and stores.
> > > 
> > > Right. This actually comes from 6abdd491698a ("ARM: mm: use
> > > inner-shareable barriers for TLB and user cache operations"), and the
> > > ARMv7 ARM doesn't mention any of this.
> > 
> > Ah; so it doesn't. :/
> > 
> > > My take is that we want to be consistent. Given that KVM/ARM on 32bit is
> > > basically ARMv7 only, I'd rather keep the ST version of the barrier
> > > here, and change it everywhere if/when someone decides to support a
> > > 32bit kernel on ARMv8 (yes, we already do as a guest, but it doesn't
> > > seem to really matter so far).
> > 
> > Keeping things consistent makes sense to me.
> 
> Does that mea this is an ack/reviewed-by ?

Sure. Feel free to take that as an Acked-by if you haven't already
queued the patches!

Thanks,
Mark.
