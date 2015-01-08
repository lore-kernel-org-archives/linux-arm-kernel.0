From: Kangkang.Shen@huawei.com (Kangkang Shen)
Date: Thu, 8 Jan 2015 19:59:23 +0000
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <2034224.H5nZdW12se@wuerfel>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <54AD917A.2040307@redhat.com> <20150107225904.GQ24989@titan.lakedaemon.net>
 <2034224.H5nZdW12se@wuerfel>
Message-ID: <9A6BBCC9BB211F40A86BE42635C3C534712FA4C6@szxeml555-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Security is a much big scale issue. The industry has all kind of solutions to deal with firmware security. In ARM system, the Firmware has been designed with higher privilege/security than OS. I will suggest we trust firmware security and focus on Linux itself.  

-----Original Message-----
From: linaro-acpi-bounces@lists.linaro.org [mailto:linaro-acpi-bounces at lists.linaro.org] On Behalf Of Arnd Bergmann
Sent: Thursday, January 08, 2015 3:27 AM
To: Jason Cooper
Cc: Rob Herring; Daniel Lezcano; Robert Richter; linaro-acpi at lists.linaro.org; Marc Zyngier; Jon Masters; Randy Dunlap; Liviu Dudau; Robert Moore; Will Deacon; linux-kernel at vger.kernel.org; linux-acpi at vger.kernel.org; Mark Brown; Rafael J. Wysocki; Lv Zheng; Catalin Marinas; Bjorn Helgaas; linux-arm-kernel at lists.infradead.org; Olof Johansson
Subject: Re: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64

On Wednesday 07 January 2015 17:59:04 Jason Cooper wrote:
> On Wed, Jan 07, 2015 at 03:05:14PM -0500, Jon Masters wrote:
> > On 01/07/2015 02:58 PM, Jon Masters wrote:
> > > On 01/07/2015 01:41 PM, Jason Cooper wrote:
> > 
> > >> One of the reasons I've really enjoyed working with ARM platforms 
> > >> and DT is the absence of this type of 'feature'.  I honestly 
> > >> don't care whether the kernel gets the board configuration info 
> > >> from DT or ACPI or FOO, as long as we can avoid the security mistakes of the past:
> > >>
> > >>   
> > >> http://www.spiegel.de/international/world/catalog-reveals-nsa-has
> > >> -back-doors-for-numerous-devices-a-940994.html
> > > 
> > > ACPI is not the great satan. I'm aware certain others in the 
> > > community have written missinformed blog posts and G+ rants 
> > > equating ACPI with SMI and even with various other system 
> > > firmware. I can't force someone to become informed on a topic, 
> > > especially if it's politically useful to them to hate on ACPI and use the security paranoia handwavy argument.
> > 
> > To clarify, and this is not directed at you Jason, it is politically 
> > useful to some who have written rants those business models are 
> > built upon being paid to enable platforms. For those folks, 
> > standardized platforms which allow a common OS approach are seen as threatening.
> 
> Ahh, thanks for clarifying.
> 
> > In the previous rants (which were really instigated as a result of 
> > the
> > above) ACPI was equated with SMM (System Management Mode), which is 
> > a bit like the Secure/Trusted world on AArch64 in which you might 
> > run another "Trusted" OS. These are the places where you want to 
> > watch out to malware of the kind cited in your link, not in ACPI tables.
> 
> fwiw, I *am* concerned about those spaces.  It seems we agree on their 
> vulnerability to attack (plus being meaty targets).
> 
> To more concisely state my other reply to you, wrt to AML, I'm 
> primarily concerned about a malicious update to the ACPI tables.  The 
> ACPI tables in the update would be otherwise normal, except for the 
> AML blob that contains some extra code.  The malicious payload.  Then, 
> a routine call into an AML (for pinctrl, say) executes the malicious code.
> 
> The plausibility and preventability of that style of attack is what 
> I'm hoping to nail down with this discussion.

If you want to run hidden code through the firmware, then doing an attack on Intel SMM or ARM TrustZone would be much harder to detect and as easy to get in, as long as you have the ability to flash arbitrary firmware.
I think this has been shown to happen in the wild. That code could go and manipulate the running kernel image to do something else.

Running code inside of the AML interpreter is fairly limited for the purpose of an attack [*], but there might be bugs in the interpreter that allow arbitrary code execution from malicious firmware. I think this case would be similar to constructing a malicious DT blob that exploits a bug in the DT parser for arbitrary code execution. The AML interpreter is a relatively large chunk of code, but it's self-contained. In comparison, the DT parser is much smaller, but has the additional
(theoretical) problem of potential buffer overflows in any drivers that use it incorrectly (e.g. format string attacks on string properties).
Another difference is that the AML code is intended to not be user-upgradable without a full firmware upgrade, while a DT blob is meant to be easily replaced if necessary without flashing the firmware, using the same permissions you need for updating the OS.

I'm deliberately not trying to draw conclusions regarding whether AML is more or less secure than DT, but the above is my understanding of the fundamental differences.

	Arnd

[*] I would assume you can get AML code to write to arbitrary physical memory locations without much effort, but it has rather limited arithmetical capabilities which makes it hard to know where to write to.

_______________________________________________
Linaro-acpi mailing list
Linaro-acpi at lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-acpi
