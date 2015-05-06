From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 May 2015 17:33:33 +0200
Subject: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe
 controller
In-Reply-To: <CAG374jCfo1165cbMrip5SrYigjNkXPyc-dqgmRbTQ0Yaw3wmDA@mail.gmail.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <CAErSpo7_ev1oYptvBObK2dS9_LXkU2_W_OMD825POE6L5Yh7Lw@mail.gmail.com>
 <CAG374jCfo1165cbMrip5SrYigjNkXPyc-dqgmRbTQ0Yaw3wmDA@mail.gmail.com>
Message-ID: <12753608.WrdVVJIhrQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 May 2015 15:40:39 Gabriel Fernandez wrote:
> On 6 May 2015 at 15:29, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > I don't really care which solution you end up with here.  But please
> > do take a look at how the other drivers solve the same problem.  Using
> > "device_initcall()" is unique in drivers/pci/host, and I don't believe
> > the problem is unique.  If several drivers have the same issue, they
> > should solve it the same way.
>
> I agree with last reply of Arnd.
>  I will mark the probe function as __init and use
> platform_driver_probe() to prevent the probe function from being
> deferred.
> And to prevent module unloading, i will use module_init only.
> 
> Ok i will wait before sending a v4.

I think in order to address Bjorn's concern, you should modify make sure
that the keystone and imx6 drivers that call hook_fault_code() do it
the same way. I think imx6 already does, but keystone does not, so
please send a patch for it, explaining why it's needed.

Conversely, I think the other dw-pcie based drivers should be changed
not to use an __init annotation at all, and instead use
module_platform_driver().

	Arnd
