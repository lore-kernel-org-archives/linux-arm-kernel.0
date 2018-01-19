From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 15:49:16 -0600
Subject: [PATCH 1/3] dt-bindings: phy: phy-rockchip-typec: add usb3 otg
 reset
In-Reply-To: <20180118174748.GA63108@google.com>
References: <1515751704-13213-1-git-send-email-william.wu@rock-chips.com>
 <1515751704-13213-2-git-send-email-william.wu@rock-chips.com>
 <20180117220715.GA112833@google.com>
 <CAFqH_52KiHQzEeaX5rFN66pMqAuVVKeWJhxnS5L4hY4XiVG8mw@mail.gmail.com>
 <20180118174748.GA63108@google.com>
Message-ID: <20180119214916.fegrzgcmbbdiesyz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 09:47:50AM -0800, Brian Norris wrote:
> On Thu, Jan 18, 2018 at 06:20:09PM +0100, Enric Balletbo Serra wrote:
> > As Brian said commit 06c47e6286d5 'usb: dwc3: of-simple: Add support
> > to get resets for the device' introduced the support to get the resets
> > from dwc3-of-simple and the queued commit 'b7e63d95c14d arm64: dts:
> > rockchip: add reset property for dwc3 controllers on rk3399' started
> > using it. Without the latest I get errors like this doing bind/unbind
> > tests.
> > 
> >    dwc3: probe of fe900000.dwc3 failed with error -110
> > 
> > I just tested these series on top of mainline, I reverted my patch
> > because otherwise two drivers are requesting the same reset and fails,
> > and I did some of the bind/unbind test. They just worked fine, and
> > seems that this is right way, so this makes me think some questions.
> 
> Actually, this was intended to coexist with DWC3 optionally controlling
> the same reset. It was written before the reset framework was rewritten
> to have shared and exclusive resets. Should this be rewritten to use
> shared resets? We'd have to modify both dwc3 core and the PHY driver.

Seems like abuse of DT to me. If you need to control the controller's 
reset from the phy driver, then get the reset out of the controller 
node. The phy node should describe the connections to the phy.

Rob
