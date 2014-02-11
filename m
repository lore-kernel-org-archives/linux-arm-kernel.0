From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 11 Feb 2014 19:01:04 +0000
Subject: [PATCH v2 1/5] drivers: of: add initialization code for reserved
 memory
In-Reply-To: <52FA33E2.4050004@samsung.com>
References: <1391515773-6112-1-git-send-email-m.szyprowski@samsung.com> <
 1391515773-6112-2-git-send-email-m.szyprowski@samsung.com> <20140205110538.
 99E47C40A89@trevor.secretlab.ca> <52FA0D6E.9090304@samsung.com> <
 20140211121316.24032C40C4D@trevor.secretlab.ca> <52FA33E2.4050004@samsung.
 com>
Message-ID: <20140211190104.7E6C5C4140E@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Feb 2014 15:29:54 +0100, Tomasz Figa <t.figa@samsung.com> wrote:
> > Yes, if only because it is an define usage of the reg property. If a
> > devtree has multiple tuples in reg, then all of those tuples should be
> > treated as reserved, even if the kernel doesn't know how to use them.
> >
> > I would not do the same for size/align/alloc-ranges unless there is a
> > very specific use case that you can define. These ones are different
> > from the static regions because they aren't ever used to protect
> > something that already exists in the memory.
> 
> Is there a reason why multiple regions could not be used for this 
> purpose, instead of adding extra complexity of having multiple reg 
> entries per region?
> 
> I.e. I don't see a difference between
> 
> reg1: region at 00000000 {
> 	reg = <0x00000000 0x1000>;
> };
> 
> reg2: region at 10000000 {
> 	reg = <0x10000000 0x1000>;
> };
> 
> user {
> 	regions = <&reg1>, <&reg2>;
> };
> 
> and
> 
> reg: region at 00000000 {
> 	reg = <0x00000000 0x1000>, <0x10000000 0x1000>;
> };
> 
> user {
> 	regions = <&reg>;
> };
> 
> except that the former IMHO better suits the definition of memory 
> region, which I see as a single contiguous range of memory and can be 
> simplified to have a single reg entry per region.

My point is rather if multiple reg tuples are found in a reserved memory
node, the kernel must respect them and reserve the memory. I'm not
arguing about whether or not that makes for a good binding.

g.
