From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2018 16:33:19 +0100
Subject: [RFC V4 0/3] arm_pmu: acpi: variant support and QCOM Falkor
 extensions
In-Reply-To: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <20180713153318.GB3049@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Agustin,

On Thu, Jul 05, 2018 at 04:23:17PM -0400, Agustin Vega-Frias wrote:
> This series is a complete re-design of V1 of the QCOM Falkor extensions [1],
> it introduces a probe table based on the HID of a device nested under the CPU
> device to allow variant detection and arm_pmu customization.
> 
> The first patch adds an additional section at the end of each ACPI probe table.
> This allows probe tables to be sentinel-delimited and better accommodate some
> APIs that require such tables.
> 
> The second patch adds the PMUv3 ACPI probe table and plumbing to allow drivers
> to plug into the ACPI PMUv3 probe sequence.
> 
> The third patch adds the PC capture extension applicable to Falkor and Saphira
> CPUs. This shows how an extension that uses sampling events hooks. A similar
> approach can be used to add RBB support and populate the sample branch stack
> from it.
> 
> The fourth patch adds the matrix-based events extension applicable to Falkor
> only.
> 
> If this found to be a reasonable extension approach other patches will be
> added to the series to build on the base QCOM extensions.

I'm mostly ok with this approach, but I have a concern with the way in which
the sysfs interface for carving up the config fields is implemented. If this
is intended to be a strict extension to the armv8 pmu architecture, then I
don't think you should be overriding the attr_groups entirely. Rather, you
should be taking the attr_groups from pmuv3 and then extending them in a way
which avoids overlapping field allocations by construction.

As it stands, you already have an overlap between the pcc bit and the
chained counter bit which Suzuki has implemented and it will be very easy to
introduce API breakage if we don't enforce this as part of the design.

Will
