From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 12 Jul 2013 10:24:42 -0700
Subject: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
In-Reply-To: <51E01547.4030204@wwwdotorg.org>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <51DEEE15.7040801@wwwdotorg.org> <3211864.2dENa1E110@avalon>
 <51E01547.4030204@wwwdotorg.org>
Message-ID: <20130712172441.GB9620@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 08:40:07AM -0600, Stephen Warren wrote:
> On 07/12/2013 04:41 AM, Laurent Pinchart wrote:
> > Hi Stephen,
[...]
> > What about splitting it in three patches that
> > 
> > - add the include/dt-bindings/pwm/pwm.h header, and update include/linux/pwm.h 
> > and Documentation/devicetree/bindings/pwm/pwm.txt
> > 
> > - update the rest of the documentation
> > 
> > - update the .dts files
> 
> I think that sounds reasonable.

Shouldn't the addition of include/dt-bindings/pwm/pwm.h be separate from
its inclusion in include/linux/pwm.h so that it can be moved more easily
(cherry-picked) to a separate repository?

> >>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> >>>
> >>>  enum pwm_polarity {
> >>>
> >>> -	PWM_POLARITY_NORMAL,
> >>> -	PWM_POLARITY_INVERSED,
> >>> +	PWM_POLARITY_NORMAL = 0,
> >>> +	PWM_POLARITY_INVERSED = 1,
> >>>
> >>>  };
> >>
> >> Rather than manually editing that to ensure the enum matches the DT bindings
> >> header, the whole point of making a separate <dt-bindings/...> directory was
> >> that drivers could include the binding header files directly to avoid having
> >> to duplicate the constant definitions. Can't <linux/pwm.h> include <dt-
> >> bindings/pwm.h> and remove that enum?
> > 
> > We could do that, but we would then need to modify all drivers to replace 
> > enum_pwm_polarity with unsigned int. Thierry, what's your opinion on this ?
> 
> Or perhaps we could keep the enums around, but force the values to match
> the DT constants:
> 
> enum pwm_polarity {
> 	PWM_POLARITY_NORMAL = PWM_POLARITY_NORMAL,
> 	PWM_POLARITY_INVERTED = PWM_POLARITY_INVERTED,
> };
> 
> (although obviously you'd need to avoid the enum and DT constants having
> the same name).

I think I've seen stuff like the following done in a few header files to
keep compatibility between enums and defines.

	enum foo {
		BAR,
	#define BAR BAR
		BAZ,
	#define BAZ BAZ
	};

Which, as I understand it, won't work in this case because DTC can only
cope with plain cpp files?

> Although this brings up one point: let's say we support ACPI/.. bindings
> in the future. The enum possibly can't match the binding values from
> every different kind of binding definition (DT, ACPI, ...) so perhaps
> rather than changing the enum definition in <linux/pwm.h>, what we
> should be doing is mapping between the different name-spaces in whatever
> of_xlate function exists for the PWM flags cell. That would be more
> flexible.

I'm not quite sure what exactly you are suggesting here. Can you
elaborate?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130712/6006a484/attachment-0001.sig>
