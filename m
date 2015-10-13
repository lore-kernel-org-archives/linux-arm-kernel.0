From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Oct 2015 16:13:55 +0100
Subject: [PATCH v1 0/2] arm64: runtime workaround for erratum #843419
In-Reply-To: <1442590800-14645-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442590800-14645-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151013151355.GQ21550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Fri, Sep 18, 2015 at 04:39:58PM +0100, Ard Biesheuvel wrote:
> This implements a workaround for the A53 erratum that may result in adrp
> instructions to produce incorrect values if they appear in either of
> the last two instruction slots of a 4 KB page.
> 
> Instead of building modules using the large code model, this approach
> uses veneers to call the adrp instructions at unaffected offsets, unless
> they can be converted into adr instructions, which is even better (this
> depends on whether the symbol is with 1 MB of the place)

As discussed at Connect, we should evaluate the performance penalty of
the existing workaround before making this more complicated. I tried to
do that today by building xfs as a module, then copying an xfs disk
image containing a git clone of the kernel into tmpfs, loop mounting
that and md5summing all of the files.

The performance eppears to be the same with and without the errata
workaround enabled, but I wondered if you had a better idea for a test
(short of writing a synthetic module)?

Will
