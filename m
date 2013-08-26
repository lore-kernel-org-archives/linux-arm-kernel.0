From: pekon@ti.com (Gupta, Pekon)
Date: Mon, 26 Aug 2013 05:22:54 +0000
Subject: [PATCH v4 3/5] net: ethernet: cpsw: introduce ti,am3352-cpsw
 compatible string
In-Reply-To: <52179AA5.3060408@ti.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-4-git-send-email-zonque@gmail.com>
 <52177052.1030308@ti.com> <52178E20.5040404@gmail.com>
 <52179448.1020906@ti.com> <52179AA5.3060408@ti.com>
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9FA84F@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On Friday 23 August 2013 10:26 PM, Santosh Shilimkar wrote:
> > On Friday 23 August 2013 12:30 PM, Daniel Mack wrote:
> >> On 23.08.2013 16:23, Santosh Shilimkar wrote:
> >>> On Friday 23 August 2013 10:16 AM, Daniel Mack wrote:
> >>>> +static const struct of_device_id cpsw_of_mtable[] = {
> >>>> +	{
> >>>> +		.compatible	= "ti,am3352-cpsw",
> >>> I didn't notice this earlier, but can't you use the IP version
> >>> as a compatible instead of using a SOC name. Whats really SOC specific
> >>> on this IP ? Sorry i have missed any earlier discussion on this but
> >>> this approach doesn't seem good. Its like adding SOC checks in the
> >>> driver subsystem.
> >> As I already mentioned in the cover letter and in the commit message, I
> >> just don't know which criteria makes most sense here.
> >>
> >> On a general note, I would say that chances that this exactly IP core
> >> with the same version number will appear on some other silicon which
> >> doesn't support the control mode register in an AM33xx fashion, is not
> >> necessarily negligible.
> >>
> >> So what that new compatible string denotes is the cpsw in a version as
> >> found on am3352 SoCs, which is actually exactly what it does.
> >>
> >> I don't have a strong opinion here, but see your point. I just don't
> >> have a better idea on how to treat that.
> >>
> > So just stick the IP version or call it cpsw-v1... cpsw-v2 etc.
> > That way if in future if someone uses those features, they can use
> > this compatible if they don't they use the one which suites that
> > SOC.
> >
> We cannot map control module register with CPSW IP version as both comes
> from different design team and CPSW ip version can be same across SoC
> and gmii sel register definition can be different. Control module
> defines may vary in different SoC as per SoC requirements.
> 
> Adding Pekon Gupta who had worked in Silicon team before.
> 
[Pekon]: My opinion here..
Uniformity in control module cannot be guaranteed, neither in register
offsets nor their functionality. Uniformity is usually maintained till the
point same person is writing the spec, or it?s a derivative device.
Control-module should not be categorized as IP, instead it?s a group of
miscellaneous logic usually consisting of following:
(a) SoC bug-fixes across silicon revisions.
(b) SoC specific logic like device_type, JTAG-ID.
(c) IP bug fixes which could not be accommodated in IP address-map.
(d) IP logic which depends on SoC configurations.

Due to this un-deterministic composition of control-module, having 
a dedicated driver for control module might not work either, as it
has to be updated | re-written for every new device.

So, Following can be used as guideline to determine compatibility
string for DT bindings..
- If binding maps to (a) and (c), .i.e., bug-fixes for SoC or IP, 
 then its most likely that these would change either in next silicon
 revision or in next devices. Hence such bindings should use *not*
 use IP compatibility strings, they _may_ use SoC-name based
 compatibility string.

- Else if binding maps to (b),.i.e., SoC specific configurations.
 then their offsets and functionality should remain same across the
 family of devices at-least, so it should use SoC-name based
 compatibility string.
- And if binding maps to (d), .i.e., IP feature but depending on SoC
 Then it can use IP based compatibility string, along with IP version.

(same approach can be used for CPSW binding used here,

with regards, pekon
