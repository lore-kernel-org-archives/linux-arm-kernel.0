From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 26 May 2016 09:32:16 +0200
Subject: [PATCH v3 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <CAMuHMdXnN-GTN4crXeWRvtWT4E2kYFvMdPPcH8z+gJb-B4PbYA@mail.gmail.com>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
 <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
 <b30c9c84-23b6-b088-4983-b2498317492b@de.bosch.com>
 <20160525004825.GC7292@verge.net.au>
 <c0fd13d5-c5c4-579b-6fad-c637bda92398@de.bosch.com>
 <edee7345-280a-0d7c-7e5a-798215fbd2b9@de.bosch.com>
 <CAMuHMdXnN-GTN4crXeWRvtWT4E2kYFvMdPPcH8z+gJb-B4PbYA@mail.gmail.com>
Message-ID: <5a697ce7-c02a-707c-55b6-6cc209b63b32@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.05.2016 09:03, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Wed, May 25, 2016 at 9:32 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> P.S.: This also results in the question why we need similar
>> r8a7795-cpg-mssr.h and r8a7796-cpg-mssr.h with just different "numbers" for
>> the same clocks. Can't we use the same numbers on all SoCs, with just having
>> wholes in the list where the clocks don't exist on a SoC? I haven't looked
>
> The CPG and MSSR block are the IP blocks that differ most among SoCs of the
> same family. Some clocks are present on H3 only, others on M3-W only.


Yes, this is my understanding as well. Is the H3 a superset? And the 
M3-W drops some clocks? Or are there really clocks which are on M3-W 
only and not on H3?


> Having a shared driver core, but different defines, is a compromise between
> reusability and avoiding mistakes in DTSes (e.g. pointing to a nonexisting
> clock due to copy and paste from another SoC).


Sounds like this is a nice additional argument to don't do all this copy 
& paste and have a common rcar3.dtsi, instead :)


>> into the manual if these numbers are given by the hardware, though.
>
> The actual numbers don't map to numbers in the datasheet, just to an unordered
> list in a table. The list of number is considered part of the DT bindings, and
> thus append-only (to be considered in case the datasheet is updated).


Ok, then there should be the option to find a clever way to define the 
clocks common on all SoCs only once. And the clocks which are different 
somehow on top, then.

To take the example from

http://article.gmane.org/gmane.linux.kernel.renesas-soc/4013

this

&scif2 {
	clocks = <&cpg CPG_MOD 310>,
		 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
		 <&scif_clk>;
};

&scif2 {
	clocks = <&cpg CPG_MOD 310>,
		 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
		 <&scif_clk>;
};

should be done better.

Best regards

Dirk
