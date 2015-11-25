From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Nov 2015 17:43:59 -0600
Subject: [PATCH v3] Documentation: dt: Add bindings for Secure-only devices
In-Reply-To: <1448381201-10729-1-git-send-email-peter.maydell@linaro.org>
References: <1448381201-10729-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <20151125234359.GA15658@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 04:06:41PM +0000, Peter Maydell wrote:
> The existing device tree bindings assume that we are only trying to
> describe a single address space with a device tree (for ARM, either
> the Normal or the Secure world). Some uses for device tree need to
> describe both Normal and Secure worlds in a single device tree. Add
> documentation of how to do this, by adding extra properties which
> describe when a device appears differently in the two worlds or when
> it only appears in one of them.
> 
> The binding describes the general principles for adding new
> properties describing the secure world, but for now we only need a
> single new property, "secure-status", which can be used to annotate
> devices to indicate that they are only visible in one of the two
> worlds.
> 
> The primary expected use of this binding is for a virtual machine
> like QEMU to describe the VM layout to a TrustZone aware firmware
> (which would then use the secure-only devices itself, and pass the DT
> on to a kernel running in the non-secure world, which ignores the
> secure-only devices and uses the rest).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This binding doesn't affect the kernel itself, but the kernel
> Documentation/ tree is the de-facto current place where all DT
> bindings are documented, so Grant suggested this was the right
> place to send a doc patch.
> 
> Changes v1->v2:
>  * list all the status/secure-status combinations explicitly
>  * use /* */ comment syntax, not //
> Changes v2->v3:
>  * use secure-foo rather than secure-reg as the example when
>    explaining how the prefixing works
>  * say how prefixing a vendor,foo property name works

Applied, thanks.

Rob

> 
>  Documentation/devicetree/bindings/arm/secure.txt | 53 ++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/secure.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
> new file mode 100644
> index 0000000..e31303f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/secure.txt
> @@ -0,0 +1,53 @@
> +* ARM Secure world bindings
> +
> +ARM CPUs with TrustZone support have two distinct address spaces,
> +"Normal" and "Secure". Most devicetree consumers (including the Linux
> +kernel) are not TrustZone aware and run entirely in either the Normal
> +world or the Secure world. However some devicetree consumers are
> +TrustZone aware and need to be able to determine whether devices are
> +visible only in the Secure address space, only in the Normal address
> +space, or visible in both. (One example of that situation would be a
> +virtual machine which boots Secure firmware and wants to tell the
> +firmware about the layout of the machine via devicetree.)
> +
> +The general principle of the naming scheme for Secure world bindings
> +is that any property that needs a different value in the Secure world
> +can be supported by prefixing the property name with "secure-". So for
> +instance "secure-foo" would override "foo". For property names with
> +a vendor prefix, the Secure variant of "vendor,foo" would be
> +"vendor,secure-foo". If there is no "secure-" property then the Secure
> +world value is the same as specified for the Normal world by the
> +non-prefixed property. However, only the properties listed below may
> +validly have "secure-" versions; this list will be enlarged on a
> +case-by-case basis.
> +
> +Defining the bindings in this way means that a device tree which has
> +been annotated to indicate the presence of Secure-only devices can
> +still be processed unmodified by existing Non-secure software (and in
> +particular by the kernel).
> +
> +Note that it is still valid for bindings intended for purely Secure
> +world consumers (like kernels that run entirely in Secure) to simply
> +describe the view of Secure world using the standard bindings. These
> +secure- bindings only need to be used where both the Secure and Normal
> +world views need to be described in a single device tree.
> +
> +Valid Secure world properties:
> +
> +- secure-status : specifies whether the device is present and usable
> +  in the secure world. The combination of this with "status" allows
> +  the various possible combinations of device visibility to be
> +  specified. If "secure-status" is not specified it defaults to the
> +  same value as "status"; if "status" is not specified either then
> +  both default to "okay". This means the following combinations are
> +  possible:
> +
> +   /* Neither specified: default to visible in both S and NS */
> +   secure-status = "okay";                          /* visible in both */
> +   status = "okay";                                 /* visible in both */
> +   status = "okay"; secure-status = "okay";         /* visible in both */
> +   secure-status = "disabled";                      /* NS-only */
> +   status = "okay"; secure-status = "disabled";     /* NS-only */
> +   status = "disabled"; secure-status = "okay";     /* S-only */
> +   status = "disabled";                             /* disabled in both */
> +   status = "disabled"; secure-status = "disabled"; /* disabled in both */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
