From: imre.deak@nokia.com (Imre Deak)
Date: Sun, 28 Mar 2010 18:40:29 +0300
Subject: [RFC PATCH] create generic alignment api (v2)
In-Reply-To: <20100328012247.GA17763@Krystal>
References: <20100328012247.GA17763@Krystal>
Message-ID: <20100328154029.GA21061@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 28, 2010 at 03:22:47AM +0200, ext Mathieu Desnoyers wrote:
>  [...]
> +/**
> + * offset_align - Calculate the offset needed to align an object on its natural
> + *                alignment towards higher addresses.
> + * @align_drift:  object offset from an "alignment"-aligned address.
> + * @alignment:    natural object alignment. Must be non-zero, power of 2.
> + *
> + * Returns the offset that must be added to align towards higher
> + * addresses.
> + */
> +static inline size_t offset_align(size_t align_drift, size_t alignment)
> +{
> +	return (alignment - align_drift) & (alignment - 1);
> +}
> +
> +/**
> + * offset_align_floor - Calculate the offset needed to align an object
> + *                      on its natural alignment towards lower addresses.
> + * @align_drift:  object offset from an "alignment"-aligned address.
> + * @alignment:    natural object alignment. Must be non-zero, power of 2.
> + *
> + * Returns the offset that must be substracted to align towards lower addresses.
> + */
> +static inline size_t offset_align_floor(size_t align_drift, size_t alignment)
> +{
> +	return (align_drift - alignment) & (alignment - 1);
> +}
> +
> +#define object_align(object)						       \
> +	((typeof(object))((size_t) object + offset_align((size_t) object,      \
> +			  sizeof(object))))
> +
> +#define object_align_floor(object)					       \
> +	((typeof(object))((size_t) object - offset_align_floor((size_t) object,\
> +			  sizeof(object))))
> +

Here object must be a pointer, but then sizeof(object) will result in
aligning to the arch word size not the object's natural alignment. Is
this what you intended?

--Imre
