From: peter.senna@collabora.co.uk (Peter Senna Tschudin)
Date: Mon, 01 Aug 2016 13:30:57 +0100
Subject: =?utf-8?q?Re=3A?==?utf-8?q?_=5BPATCH?= V3 =?utf-8?q?2=2F5=5D?=
 =?utf-8?q?_dts=2Fimx6q-b850v3=3A?= Configure IPU assignment order
In-Reply-To: <1470041647.6640.3.camel@pengutronix.de>
Message-ID: <70b6-579f4100-9-6ce4f380@208251793>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

Thank you for the prompt review.
 
On Monday, August 1, 2016 10:54 CEST, Lucas Stach <l.stach@pengutronix.de> wrote: 
 
> Am Sonntag, den 31.07.2016, 21:55 +0200 schrieb Peter Senna Tschudin:
> > As the IPU has combined limitations across multiple crtcs, and as that
> > can't be communicated to userspace at the moment, reorder the crtcs to
> > allow support to two Full-HD monitors by avoiding assigning two
> > monitors to a single IPU.
> > 
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> 
> NACK. This is a userspace issue. Changing the assignment order of the
> CRTCs just shifts the failure to a userspace that want to use CRTC 0 and
> 2 now.

Err, yeah user space issue... But how the kernel is currently telling user space about what exactly went wrong and how user space might fix it? How Weston(our user space) is going to know  that reshuffling crtcs is going to lead to success; how could it? I guess some  platform-specific code in user space is needed for this to work...

> 
> imx-drm just got atomic support and with the atomic check it should be
> possible to inform userspace in a reasonable way about such issues.

Should be possible, but I guess it isn't, and wont be until a considerable effort is put on both kernel and user space. Or am I missing something? What do you propose?

I got inspiration from: arch/arm/boot/dts/imx6q.dtsi
...
        display-subsystem {
                compatible = "fsl,imx-display-subsystem";
                ports = <&ipu1_di0>, <&ipu1_di1>, <&ipu2_di0>, <&ipu2_di1>;
        };
...

This is there for more than 2 years now, and I get that the idea here is not ordering, but just declaring.

However even if this patch is not the perfect solution, it allows us to stay close to upstream now without creating problems(does it create any issue?).

Can you reconsider or propose a concrete solution that is not more complex than our entire driver?

Thanks a lot!
