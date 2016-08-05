From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 5 Aug 2016 11:17:13 -0400
Subject: [PATCH] dmaengine: qcom_hidma: release the descriptor before the
 callback
In-Reply-To: <991ce35d-4278-629b-0240-758a2eae71a9@metafoo.de>
References: <1468465076-27324-1-git-send-email-okaya@codeaurora.org>
 <ccffcabf-1448-57a1-d18b-715cfd46e906@codeaurora.org>
 <20160724062425.GW9681@localhost>
 <971733d9-fd18-2a1b-07c0-349b47747d49@codeaurora.org>
 <20160804125525.GF9681@localhost>
 <71a15611-645f-7523-1c26-14b420aff667@codeaurora.org>
 <20160804144003.GV1041@n2100.armlinux.org.uk>
 <cff588a1-d85f-3d2c-ef61-1674d0d3ca92@codeaurora.org>
 <20160804153835.GY1041@n2100.armlinux.org.uk>
 <32e4f4c5-81d1-4a84-69af-e1b05d564bd7@codeaurora.org>
 <39afe8fb-4356-b6a3-9e17-5b60abf10040@metafoo.de>
 <874m6zybc7.fsf@belgarion.home>
 <991ce35d-4278-629b-0240-758a2eae71a9@metafoo.de>
Message-ID: <031f4b91-0640-cccf-d645-e8132d7d54bc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/5/2016 4:34 AM, Lars-Peter Clausen wrote:
> I believe we need to invest some effort to come up with clear semantics on
> what is the expected behavior when transferring a descriptor fails.
> Potentially allowing clients to choose the desired behavior, e.g. either
> abort all descriptors on error or continue with the next one.

I agree. I was leaning towards not calling the callback when an error happens
to keep the implementation simple and backwards compatible.

After Dave's change, I need to call the callback with the actual error in question.
Now, I have broken tx_status. 

If I implement DMA_ERROR into tx_status like Russell indicated, then I have the 
address space explosion problem like you indicated. 

If I report the error for the last failing cookie, is it good enough?

Or another approach is tx_status is just an indication of HW accepting the request.
All existing clients need to be changed to use Dave's error reporting for deciding
on actual success or failure for a request that was accepted by HW. tx_status
can no longer be used to check for transaction errors. It can still be used to see
if HW accepts the request (like parameter checking etc. but not for the final
result)

I like this one better.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
