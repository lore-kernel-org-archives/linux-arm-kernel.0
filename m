From: jaswinder.singh@linaro.org (Jaswinder Singh)
Date: Mon, 25 Jul 2011 19:47:14 +0530
Subject: [RFC] DMAEngine: Define generic transfer request api
In-Reply-To: <1311593444.29703.20.camel@vkoul-mobl4>
References: <1311453088-5063-1-git-send-email-jaswinder.singh@linaro.org>
	<1311593444.29703.20.camel@vkoul-mobl4>
Message-ID: <CAJe_Zhf=aW8i=KLVvt+J8p4tReR6Sk5nWpEy69kwGpctD7XAXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 July 2011 17:00, Vinod Koul <vkoul@infradead.org> wrote:
> On Sun, 2011-07-24 at 02:01 +0530, Jassi Brar wrote:
>> This is an attempt to define an api that could be used for doing
>> fancy data transfers like interleaved to contiguous copy and vice-versa.
>> Traditional SG_list based transfers tend to be very inefficient
>> in such cases. Such cases call for some very condensed api to convey
>> pattern of the transfer. This is an attempt at that condensed api.
>>
>> The api supports all 4 variants of scatter-gather and contiguous transfer.
>> Besides, it could easily represent common operations like
>> ? ? ? device_prep_dma_{cyclic, memset, memcpy}
> and how do you specify if the transfer is cyclic, memset or mempcy...
Sorry I missed this in the dense. Maybe it's a good idea to isolate
enough the context and reply in a post ?

Cyclic - I have already explained to Linus. Please ask for clarifications.

Memset (with pattern of source bus-width size)
*********
struct xfer_template {
       bool src_inc = false;
       bool dst_inc = true;
       size_t numf = memset_length / pattern_size;
       size_t frame_size = 1;
       struct data_chunk sgl[0]   represents the pattern to be repeated
};

If we need to set memory with a pattern or arbitrary length, we can
add read-width and write-width members(actually I just removed before
posting).
