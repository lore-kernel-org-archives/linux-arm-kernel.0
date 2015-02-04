From: al.stone@linaro.org (Al Stone)
Date: Tue, 03 Feb 2015 17:40:20 -0700
Subject: [PATCH v8 21/21] arm64: ACPI: additions of ACPI documentation
 for arm64
In-Reply-To: <1422881149-8177-22-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-22-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54D16A74.3030206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Much removed to cut down the size on this and to highlight a couple of specific
sections pertinent to the ACPI on ARMv8 TODO List.....

On 02/02/2015 05:45 AM, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Two more documentation files are also being added:
> (1) A verbatim copy of the "Why ACPI on ARM?" blog posting by Grant Likely,
>     which is also summarized in arm-acpi.txt, and
> 
> (2) A section by section review of the ACPI spec (acpi_object_usage.txt)
>     to note recommendations and prohibitions on the use of the numerous
>     ACPI tables and objects.  This sets out the current expectations of
>     the firmware by Linux very explicitly (or as explicitly as I can, for
>     now).
> 
> CC: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Yi Li <phoenix.liyi@huawei.com>
> CC: Mark Langsdorf <mlangsdo@redhat.com>
> CC: Ashwin Chaugule <ashwinc@codeaurora.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  Documentation/arm64/acpi_object_usage.txt | 592 ++++++++++++++++++++++++++++++
>  Documentation/arm64/why_use_acpi.txt      | 231 ++++++++++++
>  2 files changed, 823 insertions(+)
>  create mode 100644 Documentation/arm64/acpi_object_usage.txt
>  create mode 100644 Documentation/arm64/why_use_acpi.txt
> 
> diff --git a/Documentation/arm64/acpi_object_usage.txt b/Documentation/arm64/acpi_object_usage.txt
> new file mode 100644
> index 0000000..2c4f733
> --- /dev/null
> +++ b/Documentation/arm64/acpi_object_usage.txt
> @@ -0,0 +1,592 @@
> +ACPI Tables
> +-----------
> +The expectations of individual ACPI tables are discussed in the list that
> +follows.
> +
> +If a section number is used, it refers to a section number in the ACPI
> +specification where the object is defined.  If "Signature Reserved" is used,
> +the table signature (the first four bytes of the table) is the only portion
> +of the table recognized by the specification, and the actual table is defined
> +outside of the UEFI Forum (see Section 5.2.6 of the specification).
> +
[snip....]

> +
> +ACPI Objects
> +------------
> +The expectations on individual ACPI objects are discussed in the list that
> +follows:
> +
> +Name	Section		Usage for ARMv8 Linux
> +----	------------	-------------------------------------------------
> +_ADR	6.1.1		Use as needed.
[snip....]
> +
> +_DMA	6.2.4		Optional.
> +
> +_DSD	6.2.5		To be used with caution.  If this object is used, try
> +			to use it within the constraints already defined by the
> +			Device Properties UUID.  Only in rare circumstances
> +			should it be necessary to create a new _DSD UUID.
> +
> +			In either case, submit the _DSD definition along with
> +			any driver patches for discussion, especially when
> +			device properties are used.  A driver will not be 
> +			considered complete without a corresponding _DSD
> +			description.  Once approved by kernel maintainers,
> +			the UUID or device properties must then be registered
> +			with the UEFI Forum; this may cause some iteration as
> +			more than one OS will be registering entries.
> +
[snip...]

So, this is my attempt to encapsulate what I think people want to have happen
around the use of _DSD; I just want to make sure I point it out so it doesn't
inadvertently get lost somehow.

Is this far too little?  Is it sufficient?  If it only addresses part of the
concerns, what did I miss?

> +
> +_OSC	6.2.11		This method can be a global method in ACPI (i.e.,
> +			\_SB._OSC), or it may be associated with a specific
> +			device (e.g., \_SB.DEV0._OSC), or both.  When used
> +			as a global method, only capabilities published in
> +			the ACPI specification are allowed.  When used as
> +			a device-specifc method, the process described for
> +			using _DSD MUST be used to create an _OSC definition;
> +			out-of-process use of _OSC is not allowed.  That is,
> +			submit the device-specific _OSC usage description as
> +			part of the kernel driver submission, get it approved
> +			by the kernel community, then register it with the
> +			UEFI Forum.

Note that _OSC is very similar to _DSD in how it is defined in the ACPI spec.
Hence, I suggest a very similar mechanism for vetting the use of _OSC in the
kernel.  Again: is this sufficient?

> +
> +\_OSI	5.7.2		Deprecated on ARM64.  Any invocation of this method
> +			will print a warning on the console and return false.
> +			That is, as far as ACPI firmware is concerned, _OSI
> +			cannot be used to determine what sort of system is
> +			being used or what functionality is provided.  The
> +			_OSC method is to be used instead.
> +

Just a side note that patches have been sent out to deprecate _OSI for arm64,
and that a change request has been sent in to the ACPI spec committee to make
it official (with an additional forewarning that _OSI will eventually be
deprecated completely for all architectures).

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
