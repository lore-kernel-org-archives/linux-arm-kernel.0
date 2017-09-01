From: ian.eperson@dedf.co.uk (ian.eperson at dedf.co.uk)
Date: Fri, 01 Sep 2017 09:10:31 +0100
Subject: [PATCH v2 2/7] memory: atmel-ebi: Simplify SMC config code
In-Reply-To: <5a385961d7c4bcdf38f1e26d508f79af@dedf.co.uk>
References: <7c857a5fb2c61109d5db9e185f60741a@dedf.co.uk>
 <16716411.UiFsKmejXl@ada> <5a385961d7c4bcdf38f1e26d508f79af@dedf.co.uk>
Message-ID: <b8c58b20358e35608d83fddeba4994f6@dedf.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex

Looking at atmel-ebi.c in a bit more detail, my statement that 
atmel_ebi_xslate_smc_timings() returns true (>0), false (0) or error 
(<0) seems to be have been the intention but the code won?t, as it 
stands, ever return false.

This is the ?no smc-tdf-ns setting in the device tree so no other 
timings must be present? case.  What I think will happen is:

The of_property_read_u32() for "atmel,smc-tdf-ns" will return ?EINVAL 
and required will stay false.

In the for loop each the of_property_read_u32() will return ?EINVAL and 
the loop will continue for each entry in the xlate table.  Leaving ret = 
-EINVAL when the loop terminates.

The if (ret) test immediately after the out: will fail producing the 
error message and returning ret (?EINVAL) rather than required (false).

If you could confirm my logic I can construct a patch to rectify the 
problem.

Regards



Ian Eperson
DeDf Co Ltd
