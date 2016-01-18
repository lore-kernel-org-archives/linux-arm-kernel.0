From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 18 Jan 2016 11:38:08 +0000
Subject: [PATCH v2 01/16] Xen: ACPI: Hide UART used by Xen
In-Reply-To: <20160118103216.GB21067@leverpostej>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-2-git-send-email-zhaoshenglong@huawei.com>
 <20160118103216.GB21067@leverpostej>
Message-ID: <alpine.DEB.2.02.1601181135260.16178@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jan 2016, Mark Rutland wrote:
> On Fri, Jan 15, 2016 at 02:55:14PM +0800, Shannon Zhao wrote:
> > From: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > ACPI 6.0 introduces a new table STAO to list the devices which are used
> > by Xen and can't be used by Dom0. On Xen virtual platforms, the physical
> > UART is used by Xen. So here it hides UART from Dom0.
> > 
> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > ---
> > CC: "Rafael J. Wysocki" <rjw@rjwysocki.net> (supporter:ACPI)
> > CC: Len Brown <lenb@kernel.org> (supporter:ACPI)
> > CC: linux-acpi at vger.kernel.org (open list:ACPI)
> > ---
> >  drivers/acpi/bus.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index a212cef..d7a559f 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -46,6 +46,7 @@ ACPI_MODULE_NAME("bus");
> >  struct acpi_device *acpi_root;
> >  struct proc_dir_entry *acpi_root_dir;
> >  EXPORT_SYMBOL(acpi_root_dir);
> > +static u64 spcr_uart_addr;
> >  
> >  #ifdef CONFIG_X86
> >  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> > @@ -93,6 +94,17 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
> >  {
> >  	acpi_status status;
> >  
> > +	if (spcr_uart_addr != 0xffffffffffffffff) {
> 
> The SPCR spec says that the Base Address fields being zero means that
> console redirection is disabled (though I'm not clear on whether or not
> that requires the whole acpi_generic_address to be zero).
> 
> Can we not use that here?

Shannon changed the code from 0 to 0xffffffffffffffff following my
suggestion to his previous series, but I didn't realize that the SPCR
spec says 0 means no console redirection. In that case using 0 is
better.
