From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jan 2015 12:37:05 +0000
Subject: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
In-Reply-To: <54B8E38A.6020709@redhat.com>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <1421330978-9694-5-git-send-email-gregory.clement@free-electrons.com>
 <54B8C933.7020502@redhat.com> <54B8D97B.3090908@free-electrons.com>
 <54B8E38A.6020709@redhat.com>
Message-ID: <20150116123705.GM3043@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 11:10:18AM +0100, Hans de Goede wrote:
> On 16-01-15 10:27, Gregory CLEMENT wrote:

> >>>+	reg_sata0: pwr-sata0 {
> >>>+		compatible = "regulator-fixed";
> >>>+		regulator-name = "pwr_en_sata0";
> >>>+		enable-active-high;
> >>>+		regulator-always-on;

> >>done, but we're not using a power on delay anyways.

> >But if regulator-always-on prevent to switch it off in
> >suspend then yes using regulator-boot-on is better.

> AFAIK regulator-always-on means exactly that and thus likely
> is not what you want. As for using regulator-off-in-suspend
> that is not necessary as the suspend method for the acpi
> driver will already turn it off.

regulator-always-on is a bit fuzzy for suspend, if the regulator has
suspend control it'll kick in - it's really about the Linux refcounting
while it's running.  What's more concerning here is that the quick
sample of the regulators flagged as always on like the above that I
looked at in the patch don't seem to have any enable control in the DT
so this will have absolutely no effect.

> It is probably a good idea to use regulator-boot-on and
> then test things this way, and if that works use
> regulator-boot-on.

No, it's unlikely that boot-on makes sense here - it's there for cases
where we can't read back the hardware state at power on.  Generally
drivers should work regardless of the initial state of the regulator
(and modular drivers will actually break if they try to rely on boot-on
since we clean up unused regulators at boot).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150116/8ccc036e/attachment.sig>
