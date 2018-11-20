From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 20 Nov 2018 09:01:11 -0700
Subject: [PATCH v9 05/17] tpm: declare struct tpm_header
In-Reply-To: <20181120130805.GD8813@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-6-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA235BB@hasmsx108.ger.corp.intel.com>
 <20181120130805.GD8813@linux.intel.com>
Message-ID: <20181120160111.GA22023@ziepe.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 03:08:05PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 19, 2018 at 09:33:31PM +0000, Winkler, Tomas wrote:
> > 
> > > 
> > > Decleare struct tpm_header that replaces struct tpm_input_header and
> > Typo 
> 
> Thanks, will fix for the next version.
> 
> > > struct tpm_output_header.
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > >  drivers/char/tpm/tpm-interface.c  |  9 ++++-----
> > >  drivers/char/tpm/tpm.h            | 27 ++++++++++++---------------
> > >  drivers/char/tpm/tpm2-cmd.c       |  4 ++--
> > >  drivers/char/tpm/tpm2-space.c     |  6 +++---
> > >  drivers/char/tpm/tpm_i2c_atmel.c  |  5 ++---
> > > drivers/char/tpm/tpm_vtpm_proxy.c |  8 ++++----
> > >  drivers/char/tpm/xen-tpmfront.c   |  2 +-
> > >  7 files changed, 28 insertions(+), 33 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> > > interface.c
> > > index 7ac6ada8428c..cb0d44c158ae 100644
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -67,7 +67,7 @@ static int tpm_validate_command(struct tpm_chip
> > > *chip,
> > >  				 const u8 *cmd,
> > >  				 size_t len)
> > >  {
> > > -	const struct tpm_input_header *header = (const void *)cmd;
> > > +	const struct tpm_header *header = (const void *)cmd;
> > 
> > 
> > Sometimes it is casted (void *), sometimes (struct tpm_header *)
> > Better to use one convention 
> 
> I would prefer (const void *) because it is shorter form, and no
> need to duplicate the type name two times, that way also more
> readable. Anyway, agreed that we do have inconsistency with these.

It is better to pass in 'const void *cmd' than to explicitly cast like
this.

I generally discourage casts to voids to save typing, just creates
confusion what is going on. Better to try to avoid casts by
constructing the code properly.

Jason
