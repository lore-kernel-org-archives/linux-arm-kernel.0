From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Wed, 3 Jun 2015 14:03:55 +0200
Subject: [PATCH v4 1/6] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <821b4731043fef279b6a82b920707982@agner.ch>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
 <20150603081059.GA6944@breakpoint.cc>
 <821b4731043fef279b6a82b920707982@agner.ch>
Message-ID: <20150603120355.GA1668@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 11:45:50AM +0200, Stefan Agner wrote:
> On 2015-06-03 10:10, Sebastian Andrzej Siewior wrote:
> > On 2015-03-25 17:28:24 [+0100], Stefan Agner wrote:
> >> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> >> new file mode 100644
> >> index 0000000..23c1510
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/vf610_nfc.c
> > ?
> >> +static void vf610_nfc_addr_cycle(struct vf610_nfc *nfc, int column, int page)
> >> +{
> >> +	if (column != -1) {
> >> +		if (nfc->chip.options | NAND_BUSWIDTH_16)
> >> +			column = column/2;
> >> +		vf610_nfc_set_field(nfc, NFC_COL_ADDR, COL_ADDR_MASK,
> >> +				    COL_ADDR_SHIFT, column);
> >> +	}
> >> +	if (page != -1)
> >> +		vf610_nfc_set_field(nfc, NFC_ROW_ADDR, ROW_ADDR_MASK,
> >> +				    ROW_ADDR_SHIFT, page);
> >> +}
> > 
> > Do you have here also a different NAND layout on your boot-page vs
> > remaining pages? The mpc5125 has this different layout.
> 
> There is the boot configuration block which uses a Parity 13/8
> algorithm, is it that you are referring to? The format parity is in the
> main area, hence it doesn't clash with the HW ECC of the controller. One
> can use normal NAND write functions to write this page. See the

No, this sounds different. The first few pages which are used for nand-boot
are using 1056 for sector size with 32bit-ecc. This configuration is always
used depsite what the physical NAND offers. Which means if you configure later
the proper sector size for your NAND with 2K (or 4K) pages the content in the
first page(s) can not be read. Even if you disable ECC correction on read the
content looks a little different due to the two sector size beeing involved.
And I am not sure if the layout if data/ECC is the same here, to. On top of
this writting without ECC is not usefull.

The FSL's BSP for mpc5125 had some funny commands in their u-boot in order to
write the boot-page(s).

That said, I added here in the addr cycle a check for the lower page numbers
to switch the sector size at runtime. With the proper partition entry I am
able to read/write the boot pages(s). The only extra magic involved is the
rearrangement of the binary data before writing it into the boot page because
the SoC's bootmode uses a different layout here.
Since you probably not doing this at all it probably remains unique to the
mpc5125. Please keep this in mind if someone with mpc5125 comes along that it
might be usefull to switch the sector size for the boot-pages so one can
easily read/write it from linux.

Sebastian
