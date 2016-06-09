From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jun 2016 11:29:25 +0100
Subject: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
In-Reply-To: <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
 <1465465471-28740-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160609102925.GS7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 11:44:18AM +0200, Krzysztof Kozlowski wrote:
> Few drivers have a need of getting regulator supplies without knowing
> their names:
> 1. The Simple Framebuffer driver works on setup provided by bootloader
>    (outside of scope of kernel);
> 2. Generic power sequence driver may be attached to any device node.
> 
> Add a Device Tree helper for parsing "-supply" properties and returning
> allocated bulk regulator consumers.

I'm still very concerned that this is just an invitation to people to
write half baked regulator consumers and half baked DTs to go along with
it, making it a standard API that doesn't have big red flags on it that
will flag up when "normal" drivers use it is not good.  Right now this
just looks like a standard API and people are going to just start using
it.  If we are going to do this perhaps we need a separate header or
something to help flag this up.

In the case of power sequences I'd expect the sequences to perform
operations on named supplies - the core shouldn't know what the supplies
are but the thing specifying the sequence should.

>  drivers/regulator/of_regulator.c       | 86 ++++++++++++++++++++++++++++++++++
>  include/linux/regulator/of_regulator.h | 13 +++++
>  2 files changed, 99 insertions(+)

The external interface shouldn't be DT specific, the Intel people are
busy importing all of DT into ACPI so they'll doubtless want an ACPI
version.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/adf8edf5/attachment.sig>
