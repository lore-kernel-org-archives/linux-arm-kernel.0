From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Wed, 6 Dec 2017 10:59:47 +0000
Subject: [PATCH RFC 0/4] crypto: engine - Permit to enqueue all async
 requests
In-Reply-To: <20171129084121.9385-1-clabbe.montjoie@gmail.com>
References: <20171129084121.9385-1-clabbe.montjoie@gmail.com>
Message-ID: <4d58a1fc-8577-3fdb-ae6b-e1fade7c6582@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,


I am fine with this proposal: it is generic enough and I have been able 
to test and run the crypto engine with aead_request without changing any 
single line of code.

This is what I need to be able to send the AEAD extension of the 
stm32-cryp driver (successfully tested with your engine upgrade proposal).


I have also tested the stm32-hash patch.

Note that stm32-cryp (new driver applied by Herbert recently 
[https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=9e054ec21ef8344345b28603fb272fe999f735db]) 
would also need to be converted to the new crypto engine API : this is a 
trivial patch.

Thank you for your proposal, I hope that this proposal is fine for 
Herbert too.

BR


Fabien


On 29/11/17 09:41, Corentin Labbe wrote:
> Hello
>
> The current crypto_engine support only ahash and ablkcipher.
> My first patch which try to add skcipher was Nacked, it will add too many functions
> and adding other algs(aead, asymetric_key) will make the situation worst.
>
> This patchset remove all algs specific stuff and now only process generic crypto_async_request.
>
> The requests handler function pointer are now moved out of struct engine and
> are now stored directly in a crypto_engine_reqctx.
>
> The original proposal of Herbert [1] cannot be done completly since the crypto_engine
> could only dequeue crypto_async_request and it is impossible to access any request_ctx
> without knowing the underlying request type.
>
> So I do something near that was requested: adding crypto_engine_reqctx in TFM context.
> Note that the current implementation expect that crypto_engine_reqctx
> is the first member of the context.
>
> The first patch convert the crypto engine with the new way,
> while the following patchs convert the 3 existing users of crypto_engine.
> Note that this split break bisection, so probably the final commit will be all merged.
>
> The 3 latest patch were compile tested only, but the first is tested successfully
> with my new sun8i-ce driver.
>
> Regards
>
> [1] https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1474434.html
>
> Corentin Labbe (4):
>    crypto: engine - Permit to enqueue all async requests
>    crypto: omap: convert to new crypto engine API
>    crypto: virtio: convert to new crypto engine API
>    crypto: stm32: convert to the new crypto engine API
>
>   crypto/crypto_engine.c                       | 188 ++++++---------------------
>   drivers/crypto/omap-aes.c                    |  21 ++-
>   drivers/crypto/omap-aes.h                    |   3 +
>   drivers/crypto/omap-des.c                    |  24 +++-
>   drivers/crypto/stm32/stm32-hash.c            |  22 +++-
>   drivers/crypto/virtio/virtio_crypto_algs.c   |  15 ++-
>   drivers/crypto/virtio/virtio_crypto_common.h |   2 +-
>   drivers/crypto/virtio/virtio_crypto_core.c   |   3 -
>   include/crypto/engine.h                      |  46 +++----
>   9 files changed, 122 insertions(+), 202 deletions(-)
>
