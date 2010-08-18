From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 17 Aug 2010 21:25:26 -0400
Subject: [RFC PATCH 01/20] Create generic alignment API (v8)
In-Reply-To: <20100817232150.251244768@efficios.com>
References: <20100817231619.277457797@efficios.com>
	<20100817232150.251244768@efficios.com>
Message-ID: <1282094726.3268.2197.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-17 at 19:16 -0400, Mathieu Desnoyers wrote:

> +/*
> + * Align pointer on natural object alignment. Object size must be power of two.
> + */

Hmm, I wonder if we should add a compiler bug here too.

extern void __bug_obj_not_power_of_two(void);

({
	if ((sizeof(*obj) - 1) & sizeof(*obj))
		__bug_obj_not_power_of_two();
	PTR_ALIGN((obj), __alignof__(*(obj)));
})

> +#define object_align(obj)	PTR_ALIGN((obj), __alignof__(*(obj)))
> +#define object_align_floor(obj)	PTR_ALIGN_FLOOR((obj), __alignof__(*(obj)))
> +
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

I take it that theses functions can have variables passed to it for
alignment, thus a check wont help. Although, we could add a test for the
constant case.

-- Steve

> +
