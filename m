From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 6 Sep 2018 11:29:41 +0200
Subject: [PATCH 2/2] crypto: skcipher: Remove VLA usage for
 SKCIPHER_REQUEST_ON_STACK
In-Reply-To: <20180906085100.xcqqftgqg4sizkec@gondor.apana.org.au>
References: <20180904181629.20712-1-keescook@chromium.org>
 <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
 <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
 <CAOtvUMfu4-DWD4n4c5itjArAYWhGaBnPBEnkh6cbCubG-k9cCA@mail.gmail.com>
 <CAKv+Gu8bKcPksgoryaVjoD9G5KeCYrqWOCgVhqrBqGw5dCzXag@mail.gmail.com>
 <CAKv+Gu-QkCE0pY4+5anEZ0eWv-FTH1QJtOQfPcTVLcvNf7XNiA@mail.gmail.com>
 <20180906085100.xcqqftgqg4sizkec@gondor.apana.org.au>
Message-ID: <CAKv+Gu_0ehX9sLCtUYR00D4iQw+ytwmsLKmG6dgq9EnLjidKFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 September 2018 at 10:51, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Sep 06, 2018 at 10:11:59AM +0200, Ard Biesheuvel wrote:
>>
>> That way, we will almost certainly oops on a NULL pointer dereference
>> right after, but we at least the stack corruption.
>
> A crash is just as bad as a BUG_ON.
>
> Is this even a real problem? Do we have any users of this construct
> that is using it on async algorithms?
>

Perhaps not, but it is not enforced atm.

In any case, limiting the reqsize is going to break things, so that
needs to occur based on the sync/async nature of the algo. That also
means we'll corrupt the stack if we ever end up using
SKCIPHER_REQUEST_ON_STACK() with an async algo whose reqsize is
greater than the sync reqsize limit, so I do think some additional
sanity check is appropriate.
