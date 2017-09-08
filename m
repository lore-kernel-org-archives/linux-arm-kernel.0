From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 08 Sep 2017 12:59:38 -0300
Subject: [PATCH 09/14] arm64: kexec_file: add sha256 digest check in
 purgatory
In-Reply-To: <20170908025044.GD17186@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-10-takahiro.akashi@linaro.org>
 <20170824170440.GD29665@leverpostej>
 <20170825012103.GB7245@akashi-kouhiroshi-no-MacBook-Air.local>
 <20170825104133.GB3127@leverpostej> <20170908025044.GD17186@linaro.org>
Message-ID: <87lglpp4et.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


AKASHI Takahiro <takahiro.akashi@linaro.org> writes:
> On Fri, Aug 25, 2017 at 11:41:33AM +0100, Mark Rutland wrote:
>> On Fri, Aug 25, 2017 at 10:21:06AM +0900, AKASHI Takahiro wrote:
>> > On Thu, Aug 24, 2017 at 06:04:40PM +0100, Mark Rutland wrote:
>> > > On Thu, Aug 24, 2017 at 05:18:06PM +0900, AKASHI Takahiro wrote:
>> > > > +void *memcpy(void *dst, const void *src, size_t len)
>> > > > +{
>> > > > +	int i;
>> > > > +
>> > > > +	for (i = 0; i < len; i++)
>> > > > +		((u8 *)dst)[i] = ((u8 *)src)[i];
>> > > > +
>> > > > +	return NULL;
>> > > > +}
>> > > > +
>> > > > +void *memset(void *dst, int c, size_t len)
>> > > > +{
>> > > > +	int i;
>> > > > +
>> > > > +	for (i = 0; i < len; i++)
>> > > > +		((u8 *)dst)[i] = (u8)c;
>> > > > +
>> > > > +	return NULL;
>> > > > +}
>> > > > +
>> > > > +int memcmp(const void *src, const void *dst, size_t len)
>> > > > +{
>> > > > +	int i;
>> > > > +
>> > > > +	for (i = 0; i < len; i++)
>> > > > +		if (*(char *)src != *(char *)dst)
>> > > > +			return 1;
>> > > > +
>> > > > +	return 0;
>> > > > +}
>> > > 
>> > > How is the compiler prevented from "optimising" these into calls to
>> > > themselves?
>> > 
>> > I don't get what you mean by "calls to themselves."
>> 
>> There are compiler optimizations that recognise sequences like:
>> 
>> 	for (i = 0; i < len; i++)
>> 		dst[i] = src[i];
>> 
>> ... and turn those into:
>> 
>> 	memcpy(dst, src, len);
>> 
>> ... these have been known to "optimize" memcpy implementations into
>> calls to themselves. Likewise for other string operations.
>> 
>> One way we avoid that today is by writing our memcpy in assembly.
>
> I see, thanks.
>
>> Do we have a guarnatee that this will not happen here? e.g. do we pass
>> some compiler flag that prevents this?
>
> I don't know any options to do this.
> (maybe -nostdlib?)

kexec-tools calls gcc with -fno-builtin -ffreestanding (though according
to the man page, the former is implied in the latter), which tells the
compiler that the standard library may not exist. I don't know
specifically that this options turns off the memcpy optimization, but it
seems logical that it does.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
