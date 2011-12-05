From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 5 Dec 2011 18:00:08 +0100
Subject: [PATCH] mmc: mmci: Fixup error handling for dma
In-Reply-To: <CACRpkdacJxbFvSuXTsxtjZVbeTaJwNN4xy7-rvpa0U0Z4pDE_g@mail.gmail.com>
References: <1322578286-18727-1-git-send-email-ulf.hansson@stericsson.com>	<20111130222139.GW9581@n2100.arm.linux.org.uk>
 <CACRpkdacJxbFvSuXTsxtjZVbeTaJwNN4xy7-rvpa0U0Z4pDE_g@mail.gmail.com>
Message-ID: <4EDCF898.7080604@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> On Wed, Nov 30, 2011 at 11:21 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
>>>       if (!cmd->data || cmd->error) {
>>> -             if (host->data)
>>> +             if (host->data) {
>>> +                     /* Terminate the DMA transfer */
>>> +                     if (dma_inprogress(host))
>>> +                             mmci_dma_data_error(host);
>> Doesn't this leave the DMA buffers mapped?

Correct, but it will be handled in post_request function.

> 
> Yep it needs an mmci_dma_unmap() call too AFAICT,
> Ulf will you update?

Actually it's needs only dma_unmap_sg, but as stated this should be 
handled in mmci_post_request.

By, the way - I spoke to Per F?rlin who implemented the pre_request and 
post_request functions; we will soon push some clean-up patches for 
improved error handling and how to manage the cookie better. Right now 
it is kind of hard to follow the error path, I think. We hope this shall 
be improved then.

Although it should have nothing to do with this patch directly, since 
this is a bugfix only.

BR
Ulf Hansson
