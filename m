From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed, 18 Jul 2018 21:20:00 +0530
Subject: [PATCH v4 0/6] Add Actions Semiconductor Owl S900 I2C support
In-Reply-To: <20180711024502.GA4739@Mani-XPS-13-9360>
References: <20180701172305.15663-1-manivannan.sadhasivam@linaro.org>
 <20180711024502.GA4739@Mani-XPS-13-9360>
Message-ID: <20180718155000.GA3061@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 08:15:02AM +0530, Manivannan Sadhasivam wrote:
> On Sun, Jul 01, 2018 at 10:52:59PM +0530, Manivannan Sadhasivam wrote:
> > This patchset adds I2C controller support for Actions Semiconductor S900 SoC.
> > This driver has been structured in a way such that there will be only
> > one controller driver for the whole Owl family series (S500, S700 and
> > S900 SoCs).
> > 
> > There are 6 I2C controllers with separate memory mapped register space.
> > The I2C controller can handle atmost two messages concatenated by a
> > repeated start via its internal address feature. Hence the driver
> > uses this feature for messages of length greater than 1. In those cases,
> > the first message of the combined message should be a `write` with maximum
> > message length 6 and the second message's maximum length should be 240 bytes.
> > 
> > As far as the bus speed is concerned, this driver only supports
> > Standard (100KHz) and High speed (400KHz) for now.
> > 
> > The pinctrl definitions are only available for I2C0, I2C1 and I2C2.
> > With the mux option available only for I2C0.
> > 
> > For Bubblegum-96 board utilizing the S900 SoC, only I2C1 and I2C2 which
> > are exposed on the Low speed expansion connector are enabled.
> > 
> > This series depends on the pinctrl patch [1] is still not merged by the
> > platform maintainer Andreas but it has been reviewed by the pinctrl maintainer
> > Linus Walleij. For the reference, I have queued up all reviewed dts patches
> > in my tree [2] from which Andreas is picking them for 4.19.
> > 
> > For this series, since the dts patches will go through the ARM SoC tree,
> > Andreas will pick it up once it is reviewed.
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://patchwork.kernel.org/patch/10322937/
> > [2] https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next
> > 
> 
> Hi Andy, Peter,
> 
> Just a gentle ping on this v4!
> 
> Thanks,
> Mani
>

Hi,

Any update on this patchset?

Thanks,
Mani

> > Changes in v4:
> > 
> > As per Andy and Peter review:
> > 
> > * Used spinlock for accessing most of the register access (only parts
> >   involved sleep/long-busy-wait has been excluded)
> > * Removed returning 0 and added -ENXIO if the msg_ptr not equals to
> >   message length
> > * Added DIV_ROUND_UP for setting clock frequency
> > * Changed one non-atomic mdelay instance to usleep_range
> > * Moved pinctrl definition patch before dts patch
> > * Fixed the driver to support only 100KHz and 400KHz frequencies
> > 
> > Changes in v3:
> > 
> > As per Peter, Andy and Andreas review:
> > 
> > * Removed owl_i2c_reset function from interrupt handler since it
> >   involves the use of delays.
> > * Fixed the return path in owl_i2c_master_xfer and added a note
> > * Changed "base" parameter to "reg" in owl_i2c_update_reg for better
> >   understandability
> > * Ordered the includes in alphabetical order
> > * Small changes to defines and added comma at the end of struct members
> > * Removed rendundant 0 assignment in owl_i2c_master_xfer
> > * Changed all OWL naming convention to Owl and also changed Actions Semi
> >   naming to Actions Semiconductor
> > 
> > Changes in v2:
> > 
> > As per Andy's review:
> > * Modified infinite loops to fixed number of retries
> > * Used i2c_8bit_addr_from_msg for constructing the slave address
> > * Removed unnecessary parenthesis around defines
> > * Modified certain dev_warn to dev_dbg
> > * Modified the error handling to more generic pattern
> > 
> > * Fixed the return value in owl_i2c_master_xfer
> > * Added MAINTAINERS patch for I2C driver and its binding
> > 
> > Manivannan Sadhasivam (6):
> >   dt-bindings: i2c: Add binding for Actions Semiconductor Owl I2C
> >     controller
> >   arm64: dts: actions: Add pinctrl definition for S900 I2C controller
> >   arm64: dts: actions: Add Actions Semiconductor S900 I2C controller
> >     nodes
> >   arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
> >   i2c: Add Actions Semiconductor Owl family S900 I2C driver
> >   MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
> > 
> >  .../devicetree/bindings/i2c/i2c-owl.txt       |  27 +
> >  MAINTAINERS                                   |   2 +
> >  .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 +
> >  .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
> >  arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
> >  drivers/i2c/busses/Kconfig                    |   7 +
> >  drivers/i2c/busses/Makefile                   |   1 +
> >  drivers/i2c/busses/i2c-owl.c                  | 504 ++++++++++++++++++
> >  8 files changed, 641 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
> >  create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
> >  create mode 100644 drivers/i2c/busses/i2c-owl.c
> > 
> > -- 
> > 2.17.1
> > 
