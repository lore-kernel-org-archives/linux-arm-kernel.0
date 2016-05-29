From: bhe@redhat.com (Baoquan He)
Date: Sun, 29 May 2016 21:29:10 +0800
Subject: [PATCH kexec-tools 07/32] kexec: fix warnings caused by
 selecting 64-bit file IO on 32-bit platforms
In-Reply-To: <20160528135320.GQ19428@n2100.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSV-0004hZ-CH@e0050434b2927.dyn.arm.linux.org.uk>
 <20160528113354.GB2429@x1.redhat.com>
 <20160528135320.GQ19428@n2100.arm.linux.org.uk>
Message-ID: <20160529132910.GA5752@x1.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/16 at 02:53pm, Russell King - ARM Linux wrote:
> On Sat, May 28, 2016 at 07:33:54PM +0800, Baoquan He wrote:
> > On 05/03/16 at 11:21am, Russell King wrote:
> > > diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
> > > index 9df601b..5e24629 100644
> > > --- a/kexec/kexec-uImage.c
> > > +++ b/kexec/kexec-uImage.c
> > > @@ -82,7 +82,8 @@ int uImage_probe(const unsigned char *buf, off_t len, unsigned int arch)
> > >  	if (be32_to_cpu(header.ih_size) > len - sizeof(header)) {
> > >  		printf("uImage header claims that image has %d bytes\n",
> > >  				be32_to_cpu(header.ih_size));
> > > -		printf("we read only %ld bytes.\n", len - sizeof(header));
> > > +		printf("we read only %lld bytes.\n",
> > > +		       (long long)len - sizeof(header));
> > 
> > With "D_FILE_OFFSET_BITS=64" adding, off_t is identical to off64_t, is
> > that necessary to still take a type conversion here?
> 
> The printf format specifies an argument of "long long" type, which is
> defined as a data type of at least 64-bits wide.  So, it's more
> correct to cast to long long, rather than relying on off64_t being
> the same size as long long.

Ok, it's fine to have an explict cast here so that people don't need
to consider off_t is long or long long.

Ack this patch.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan
