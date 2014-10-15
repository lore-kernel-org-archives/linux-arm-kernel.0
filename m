From: dyoung@redhat.com (Dave Young)
Date: Wed, 15 Oct 2014 15:08:54 +0800
Subject: [RFC PATCH] arm64/efi: use stable virtual mappings for UEFI
 runtime services
In-Reply-To: <20141014104221.GI16598@leverpostej>
References: <1412789936-4908-1-git-send-email-ard.biesheuvel@linaro.org>
 <1413240766.31184.69.camel@smoke>
 <20141014021721.GA4201@darkstar.nay.redhat.com>
 <20141014104221.GI16598@leverpostej>
Message-ID: <20141015070854.GB1527@dhcp-16-198.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/14 at 11:42am, Mark Rutland wrote:
> On Tue, Oct 14, 2014 at 03:17:21AM +0100, Dave Young wrote:
> > Hi, Geoff
> > 
> > On 10/13/14 at 03:52pm, Geoff Levand wrote:
> > > Hi Ard,
> > > 
> > > On Wed, 2014-10-08 at 19:38 +0200, Ard Biesheuvel wrote:
> > > > I haven't tested this code under kexec myself, but I have confirmed that
> > > > the runtime services work as expected (rtc-efi and efivars). The comments
> > > > that Mark Salter and Will Deacon gave on the id mapping patch here
> > > 
> > > I applied this patch to my kexec master branch [1] and tested a basic
> > > kexec re-boot using the FVP_Base_AEMv8A-AEMv8A_0.8_5602 model and the
> > > 14.09 LEG EFI build.
> > > 
> > > It crashes when the 2nd stage kernel is starting up on the first
> > > dereference of the c16 variable in uefi_init():
> > > 
> > >   c16 = early_memremap(efi.systab->fw_vendor, sizeof(vendor));
> > >   if (c16) {
> > >     for (i = 0; i < (int) sizeof(vendor) - 1 && *c16; ++i) {
> > >                                                 ^^^^ crashes here
> > > 
> > > early_memremap() returns 0xFFFFFFBFFBCBF618, and the dereference
> > > starts the crash.  I did not look into it further.
> > 
> > This is an expected behaviour as I mentioned before, we need save fw_vendor
> > and the other two physical addresses and pass them to 2nd kernel.
> > 
> > UEFI firmware will convert them to virtual address after entering virtual mode.
> 
> So long as we know they are virtual addresses (implied by whatever way
> we detect we're in virtual mode), and we know the virt->phys mappings
> (which are in the EFI memmap passed via the DTB), we should be able to
> figure out those physical addresses without having to pass them
> explicitly, regardless of what mapping is used.

It's possible to get the physical address from the converted virt address in this case.
