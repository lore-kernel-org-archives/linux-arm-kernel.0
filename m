From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 9 Oct 2015 11:27:00 -0500
Subject: [PATCH 0/9] Further mvebu PCIe patches
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
Message-ID: <20151009162700.GA16112@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 03, 2015 at 07:12:28PM +0100, Russell King - ARM Linux wrote:
> Jason, Thomas,
> 
> Here are further PCIe patches which follow on from the previous set of
> six I sent earlier in September.  This set:
> 
> * Separates the DT parsing from the use of this parsed data.
> * Fixes memory leaks from kasprintf() and refcount leaks of the DT
>   node where we break out from the loop early.
> * Uses gpio_set_value_cansleep() so that GPIOs on I2C expanders can
>   be used for the PCIe reset functionality.
> * Switch to using devm_kcalloc() instead of devm_kzalloc(), which
>   eliminates the multiplication, moving it into core code.
> * Switch to using a gpio descriptor for the reset gpio, which can
>   contain the active level information from DT.  (It would be nice
>   if gpiolib automated some of the resource claiming there.)
> * Make PERST# vs clock timing to match PCIe specifications.  PCIe
>   specs require the clock to be running for 100us prior to releasing
>   reset.
> * Add the standard PCIe capability block in root port form to the
>   emulated PCIe configuration block.  This allows the PCI layer to
>   identify the "host bridge" as a PCIe device, and allows us to
>   take advantage of the code in drivers/pci/pcie, particularly
>   aspm for link power management.
> * As a result of identifying ourselves as a PCIe root port, this
>   eliminates the need to special case accesses to non-slot 0 in
>   the driver; the lack of other "slots" is something which the
>   generic PCI code knows about for PCIe root ports.
> 
>  drivers/pci/host/pci-mvebu.c | 404 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 305 insertions(+), 99 deletions(-)

Applied to pci/host-mvebu for v4.4 with Tested-by from Willy, Andrew,
and Thomas, and Reviewed-by from Thomas.  I adjusted subject line
capitalization to match the history.  Thanks, Russell and reviewers
and testers!

Bjorn
