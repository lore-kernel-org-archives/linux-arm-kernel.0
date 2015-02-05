From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Thu, 05 Feb 2015 16:45:14 +0100
Subject: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
In-Reply-To: <54D2AA9B.7010800@codeaurora.org>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org>
 <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6>
 <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum>
 <54D0F179.1040906@gmail.com> <54D2AA9B.7010800@codeaurora.org>
Message-ID: <54D3900A.9060200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/02/2015 00:26, Stephen Boyd wrote:
>> If you want me to I can enlarge the search to other directories.
> Yes please do. And if you could share the coccinelle patch that would be
> great. Thanks.
>
structclk.cocci is the coccinelle patch
structclk-arm.patch is the result I got when applying it to the arch/arm 
directory

Is there anything else I can do to help?


-------------- next part --------------
A non-text attachment was scrubbed...
Name: structclk-arm.patch
Type: text/x-patch
Size: 2512 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150205/7f8a2e33/attachment.bin>
-------------- next part --------------
/// Find any attempt to compare or dereference struct clk pointers.
///
// Confidence: High
// Copyright: (C) 2015 Quentin Lambert, INRIA/LiP6. GPLv2
// URL: http://coccinelle.lip6.fr/
// Options: --recursive-includes --relax-include-path
// Options: --include-headers-for-types

virtual context
virtual org
virtual report


// ----------------------------------------------------------------------------

@comparison_dereference depends on context || org || report@
struct clk *x1, x2;
position j0;
@@

(
*  x1 at j0 == x2
|
*  x1 at j0 != x2
|
*  *x1 at j0
)

// ----------------------------------------------------------------------------

@script:python comparison_dereference_org depends on org@
j0 << comparison_dereference.j0;
@@

msg = "WARNING trying to compare or dereference struct clk pointers."
coccilib.org.print_todo(j0[0], msg)

// ----------------------------------------------------------------------------

@script:python comparison_dereference_report depends on report@
j0 << comparison_dereference.j0;
@@

msg = "WARNING trying to compare or dereference struct clk pointers."
coccilib.report.print_report(j0[0], msg)
