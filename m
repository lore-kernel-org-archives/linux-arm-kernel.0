From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Mar 2016 14:56:56 +0000
Subject: DWord alignment on ARMv7
In-Reply-To: <2494410.DJhrOHD4yE@wuerfel>
References: <56D8BA3F.7050508@pengutronix.de> <72900410.JPa1IHPXo5@wuerfel>
 <20160304134651.GB19428@n2100.arm.linux.org.uk>
 <2494410.DJhrOHD4yE@wuerfel>
Message-ID: <20160304145656.GC19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 03:41:58PM +0100, Arnd Bergmann wrote:
> On Friday 04 March 2016 13:46:51 Russell King - ARM Linux wrote:
> > On Fri, Mar 04, 2016 at 02:30:23PM +0100, Arnd Bergmann wrote:
> > > Ah, I thought it only required 32-bit alignment like ldm/stm, but it
> > > seems that it won't do that. However, an implementation like
> > > 
> > > unsigned long long get_unaligned_u64(void *p)
> > > {
> > >         unsigned long long upper, lower;
> > >         lower = *(unsigned long*)p;
> > >         upper = *(unsigned long*)(p+4);
> > > 
> > >         return lower | (upper << 32);
> > > }
> > > 
> > > does get compiled into
> > > 
> > > 00000000 <f>:
> > >    0:   e8900003        ldm     r0, {r0, r1}
> > >    4:   e12fff1e        bx      lr
> > 
> > I think it may be something of a bitch to work around, because the
> > compiler is going to do stuff like that behind your back.
> > 
> > The only way around that would be to bypass the compiler by using
> > asm(), but then you end up bypassing the instruction scheduling too.
> > That may not matter, as the resulting overhead may still be lower.
> 
> I think the compiler is correctly optimizing the code according to
> what we tell it about the alignment here:

It is, that's not what I was saying though - I wasn't saying whether or
not the compiler is correctly optimising the code (it is.)  I was saying
that we _don't_ want the compiler optimising the code in this way here -
that's a completely _different_ point.

> The implementation appears to be suboptimal for cross-endian loads
> though, as gcc-5.3 does not use the 'rev' instruction here but
> falls back on byte accesses. We can easily fix that by introducing
> one more generic implementation for the cross-endian accesses doing
> 
> static __always_inline void put_unaligned_be64(u64 val, void *p)
> {
>        __put_unaligned_cpu64((u64 __force)cpu_to_be64(val), p);
> }
> static __always_inline void put_unaligned_be32(u32 val, void *p)
> {
>        __put_unaligned_cpu32((u32 __force)cpu_to_be32(val), p);
> }
> static __always_inline void put_unaligned_be16(u16 val, void *p)
> {
>        __put_unaligned_cpu16((u16 __force)cpu_to_be16(val), p);
> }
> 
> which is better on ARM than the currently used
> 
> static inline void __put_unaligned_le16(u16 val, u8 *p)
> {
>         *p++ = val;
>         *p++ = val >> 8;
> }
> static inline void __put_unaligned_le32(u32 val, u8 *p)
> {
>         __put_unaligned_le16(val >> 16, p + 2);
>         __put_unaligned_le16(val, p);
> }
> static inline void __put_unaligned_le64(u64 val, u8 *p)
> {
>         __put_unaligned_le32(val >> 32, p + 4);
>         __put_unaligned_le32(val, p);
> }
> 
> because it will allow using ldr/str+rev for unaligned
> cross-endian accesses, but disallow ldm/stm+rev.

Looks like it's going to make the unaligned stuff even more of a rabbit
warren of include files.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
