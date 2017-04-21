From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 21 Apr 2017 18:14:02 +0100
Subject: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
In-Reply-To: <a73c87d3-59fc-843b-a4e1-d9f5201bffd9@gmail.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
 <CALdTtnuO=592n+PoR_kkdTyeFYRd90VyPf0JLwnEo7DtXwzoPA@mail.gmail.com>
 <a73c87d3-59fc-843b-a4e1-d9f5201bffd9@gmail.com>
Message-ID: <20170421171352.GA27801@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 10:22:52AM +0800, zhichang.yuan wrote:
> Hi, Dann,
> 
> 
> 
> On 04/21/2017 04:57 AM, dann frazier wrote:
> > On Thu, Mar 30, 2017 at 9:26 AM, zhichang.yuan
> > <yuanzhichang@hisilicon.com> wrote:
> >> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access I/O
> >> with some special host-local I/O ports known on x86. To access the I/O
> >> peripherals, an indirect-IO mechanism is introduced to mapped the host-local
> >> I/O to system logical/fake PIO similar the PCI MMIO on architectures where no
> >> separate I/O space exists. Just as PCI MMIO, the host I/O range should be
> >> registered before probing the downstream devices and set up the I/O mapping.
> >> But current ACPI bus probing doesn't support these indirect-IO hosts/devices.
> >>
> >> This patch introdueces a new ACPI handler for this device category. Through the
> >> handler attach callback, the indirect-IO hosts I/O registration is done and
> >> all peripherals' I/O resources are translated into logic/fake PIO before
> >> starting the enumeration.
> >>
> >> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> >> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >> ---
> >>  drivers/acpi/Makefile          |   1 +
> >>  drivers/acpi/acpi_indirectio.c | 344 +++++++++++++++++++++++++++++++++++++++++
> >>  drivers/acpi/internal.h        |   5 +
> >>  drivers/acpi/scan.c            |   1 +
> >>  4 files changed, 351 insertions(+)
> >>  create mode 100644 drivers/acpi/acpi_indirectio.c
> >>
> >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >> index a391bbc..10e5f2b 100644
> >> --- a/drivers/acpi/Makefile
> >> +++ b/drivers/acpi/Makefile
> >> @@ -57,6 +57,7 @@ acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
> >>  acpi-y                         += acpi_lpat.o
> >>  acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
> >>  acpi-$(CONFIG_ACPI_WATCHDOG)   += acpi_watchdog.o
> >> +acpi-$(CONFIG_INDIRECT_PIO)    += acpi_indirectio.o
> >>
> >>  # These are (potentially) separate modules
> >>
> >> diff --git a/drivers/acpi/acpi_indirectio.c b/drivers/acpi/acpi_indirectio.c
> >> new file mode 100644
> >> index 0000000..c8c80b5
> >> --- /dev/null
> >> +++ b/drivers/acpi/acpi_indirectio.c
> >> @@ -0,0 +1,344 @@
> 
> [snip]
> 
> >> +acpi_build_logiciores_template(struct acpi_device *adev,
> >> +                       struct acpi_buffer *buffer)
> >> +{
> >> +       acpi_handle handle = adev->handle;
> >> +       struct acpi_resource *resource;
> >> +       acpi_status status;
> >> +       int res_cnt = 0;
> >> +
> >> +       status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> >> +                                    acpi_count_logiciores, &res_cnt);
> >> +       if (ACPI_FAILURE(status) || !res_cnt) {
> >> +               dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
> >> +       buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
> > 
> > (Seth Forshee noticed this issue, just passing it on)
> > 
> > Should this just allocate the full buffer->length? That would keep the
> > length attribute accurate (possibly avoiding an off-by-1 error later).
> > It's not clear what the trailing byte is needed for, but other drivers
> > allocate it as well (drivers/acpi/pci_link.c and
> > drivers/platform/x86/sony-laptop.c).
> 
> Thanks for your suggestion!
> 
> I also curious why this one appended byte is needed as it seems the later
> acpi_set_current_resources() doesn't use this byte.
> And I tested without setting the buffer->length as the length of resource list
> directly, it seems ok.
> 
> But anyway, it looks more reasonable to allocate the memory with the
> buffer->length rather than buffer->length - 1;
> 
> I was made the V9 patch-set, and I can add your suggestion there. But I also
> awaiting for ARM64 ACPI maintainer's comment about this patch before really
> sending V9. I wonder whether there is better way to make our indirect-IO devices
> can be assigned the logic PIO before the enumeration...
> 
> Lorenzo, Hanjun, what do you think about this patch?

I will get to it shortly, sorry for the delay.

Thanks,
Lorenzo
