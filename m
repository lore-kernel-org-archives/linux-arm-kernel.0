From: vilhelm.gray@gmail.com (William Breathitt Gray)
Date: Sat, 21 Jul 2018 12:26:10 -0400
Subject: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
In-Reply-To: <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
 <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
Message-ID: <20180721162610.GA15622@sophia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 08:49:54PM -0700, Andrew Morton wrote:
>On Thu, 21 Jun 2018 17:07:08 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> This patch introduces the Generic Counter interface for supporting
>> counter devices.
>> 
>
>+EXPORT_SYMBOL(count_direction_str);
>+EXPORT_SYMBOL(count_mode_str);
>+EXPORT_SYMBOL(counter_signal_enum_read);
>+EXPORT_SYMBOL(counter_signal_enum_write);
>+EXPORT_SYMBOL(counter_signal_enum_available_read);
>+EXPORT_SYMBOL(counter_count_enum_read);
>+EXPORT_SYMBOL(counter_count_enum_write);
>+EXPORT_SYMBOL(counter_count_enum_available_read);
>+EXPORT_SYMBOL(counter_device_enum_read);
>+EXPORT_SYMBOL(counter_device_enum_write);
>+EXPORT_SYMBOL(counter_device_enum_available_read);
>+EXPORT_SYMBOL(signal_read_value_set);
>+EXPORT_SYMBOL(count_read_value_set);
>+EXPORT_SYMBOL(count_write_value_get);
>+EXPORT_SYMBOL(counter_register);
>+EXPORT_SYMBOL(counter_unregister);
>+EXPORT_SYMBOL(devm_counter_register);
>+EXPORT_SYMBOL(devm_counter_unregister);
>
>The naming is a bit chaotic.  Most of the symbols start with counter_,
>which is good.  But a handful do not.

I can prefix these exported symbols with "counter_" to help make it
clear they all belong to the Generic Counter API. I'll keep the devm_*
symbols the same to match the naming convention in the other subsystems
I see (watchdog, IIO, GPIO, etc.).

>
>Also, symbols called signal_* make my head spin - Linux already has a
>firmly ingrained notion of what a signal is, and this ain't it ;)
>Although the kernel tends to use sig_ for signals-as-an-IPC-thing.
>
>Also, many many drivers deal with signals-as-an-electrical-thing - is
>it appropriate for this particular driver to take that namespace?

In the context of the Generic Counter paradigm, a "Signal" is an
abstraction for the stream of data that is fed to the counter device for
evaluation (triggering updates for the readable "Count"). In many cases
a "Signal" correlates with a physical electrical line (for example the A
and B electrical lines for a quadrature encoder), but this isn't a hard
requirement as the paradigm permits more abstract data streams.

I decided on "Signal" to match the naming convention that appears in the
datasheets of many counter devices, but "Line" may be a decent
alternative name we could use to indicate a counter device input data
stream.

I'd like to get some other opinions as well before I make a naming
change to "Signal" -- whether to stay with "Signal," switch to "Line," or
rename to something else. For what it's worth, I think it's unlikely for
a counter device driver author to confuse a Counter Signal with the
Linux OS signal within the context of the Generic Counter paradigm and
their respective counter device datasheet.

William Breathitt Gray
