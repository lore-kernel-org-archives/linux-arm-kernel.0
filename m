From: andreiw@motorola.com (Andrei Warkentin)
Date: Sat, 19 Feb 2011 23:56:39 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102191220.54815.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
	<AANLkTimWAnPg2sYiLbfZXAAUiu7P5T3LmNoVbPi9RTEG@mail.gmail.com>
	<201102191220.54815.arnd@arndb.de>
Message-ID: <AANLkTincLPnW90xvE304dCjkTbKUQGf6H8yWDVdz5Kh4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 5:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 19 February 2011 00:17:51 Andrei Warkentin wrote:
>> # echo 0 > /sys/block/mmcblk0/device/page_size
>> # ./flashbench -A -b 1024 /dev/block/mmcblk0p9
>> write align 8388608 ? ? pre 3.59ms ? ? ?on 6.54ms ? ? ? post 3.65ms ? ? diff 2.92ms
>> write align 4194304 ? ? pre 4.13ms ? ? ?on 7.37ms ? ? ? post 4.27ms ? ? diff 3.17ms
>> write align 2097152 ? ? pre 3.62ms ? ? ?on 6.81ms ? ? ? post 3.94ms ? ? diff 3.03ms
>> write align 1048576 ? ? pre 3.62ms ? ? ?on 6.53ms ? ? ? post 3.55ms ? ? diff 2.95ms
>> write align 524288 ? ? ?pre 3.62ms ? ? ?on 6.51ms ? ? ? post 3.63ms ? ? diff 2.88ms
>> write align 262144 ? ? ?pre 3.62ms ? ? ?on 6.51ms ? ? ? post 3.63ms ? ? diff 2.89ms
>> write align 131072 ? ? ?pre 3.62ms ? ? ?on 6.5ms ? ? ? ?post 3.63ms ? ? diff 2.88ms
>> write align 65536 ? ? ? pre 3.61ms ? ? ?on 6.49ms ? ? ? post 3.62ms ? ? diff 2.88ms
>> write align 32768 ? ? ? pre 3.61ms ? ? ?on 6.49ms ? ? ? post 3.61ms ? ? diff 2.88ms
>> write align 16384 ? ? ? pre 3.68ms ? ? ?on 107ms ? ? ? ?post 3.51ms ? ? diff 103ms
>> write align 8192 ? ? ? ?pre 3.74ms ? ? ?on 121ms ? ? ? ?post 3.91ms ? ? diff 117ms
>> write align 4096 ? ? ? ?pre 3.88ms ? ? ?on 3.87ms ? ? ? post 3.87ms ? ? diff -2937ns
>> write align 2048 ? ? ? ?pre 3.89ms ? ? ?on 3.88ms ? ? ? post 3.88ms ? ? diff -8734ns
>> # fjnh84 at fjnh84-desktop:~/src/n/src/flash$ adb -s 17006185428011d7 shell
>> # echo 8192 > /sys/block/mmcblk0/device/page_size
>> # cd data
>> # ./flashbench -A -b 1024 /dev/block/mmcblk0p9
>> write align 8388608 ? ? pre 3.33ms ? ? ?on 6.8ms ? ? ? ?post 3.65ms ? ? diff 3.31ms
>> write align 4194304 ? ? pre 4.34ms ? ? ?on 8.14ms ? ? ? post 4.53ms ? ? diff 3.71ms
>> write align 2097152 ? ? pre 3.64ms ? ? ?on 7.31ms ? ? ? post 4.09ms ? ? diff 3.44ms
>> write align 1048576 ? ? pre 3.65ms ? ? ?on 7.52ms ? ? ? post 3.65ms ? ? diff 3.87ms
>> write align 524288 ? ? ?pre 3.62ms ? ? ?on 6.8ms ? ? ? ?post 3.63ms ? ? diff 3.17ms
>> write align 262144 ? ? ?pre 3.62ms ? ? ?on 6.84ms ? ? ? post 3.63ms ? ? diff 3.22ms
>> write align 131072 ? ? ?pre 3.62ms ? ? ?on 6.85ms ? ? ? post 3.44ms ? ? diff 3.32ms
>> write align 65536 ? ? ? pre 3.39ms ? ? ?on 6.8ms ? ? ? ?post 3.66ms ? ? diff 3.28ms
>> write align 32768 ? ? ? pre 3.64ms ? ? ?on 6.86ms ? ? ? post 3.66ms ? ? diff 3.21ms
>> write align 16384 ? ? ? pre 3.67ms ? ? ?on 6.86ms ? ? ? post 3.65ms ? ? diff 3.2ms
>> write align 8192 ? ? ? ?pre 3.66ms ? ? ?on 6.84ms ? ? ? post 3.64ms ? ? diff 3.19ms
>> write align 4096 ? ? ? ?pre 3.71ms ? ? ?on 3.71ms ? ? ? post 3.64ms ? ? diff 38.6?s
>> write align 2048 ? ? ? ?pre 3.71ms ? ? ?on 3.71ms ? ? ? post 3.72ms ? ? diff -656ns
>>
>> This was with the split unaligned accesses patch... Which I am
>> attaching for comments.
>
> I agree, this is very fascinating behavior. 100ms second latency for a
> single 2KB access is definitely something we should try to avoid, and I
> wonder why the drive decides to do that. It must get into a state where
> it requires an extra garbage collection (you mentioned that earlier).
>
> The numbers you see here are taken over multiple runs. Do you see a lot
> of fluctuation when doing this with --count=1?
>

Yep. Quite a bit.

# ./flashbench -c 1 -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 4.52ms	on 7.58ms	post 3.93ms	diff 3.36ms
write align 4194304	pre 5.97ms	on 8.69ms	post 4.36ms	diff 3.53ms
write align 2097152	pre 3.57ms	on 7.96ms	post 4.6ms	diff 3.88ms
write align 1048576	pre 5.33ms	on 27.4ms	post 4.88ms	diff 22.3ms
write align 524288	pre 49.3ms	on 31.4ms	post 14.9ms	diff -679265
write align 262144	pre 39.7ms	on 38.3ms	post 5.27ms	diff 15.8ms
write align 131072	pre 33.8ms	on 45.4ms	post 5.26ms	diff 25.9ms
write align 65536	pre 34.4ms	on 40.9ms	post 3.3ms	diff 22.1ms
write align 32768	pre 30.2ms	on 44.8ms	post 5.13ms	diff 27.1ms
write align 16384	pre 44.5ms	on 5.05ms	post 33.3ms	diff -338542
write align 8192	pre 25.5ms	on 70.6ms	post 25.3ms	diff 45.2ms
write align 4096	pre 4.89ms	on 4.47ms	post 5.29ms	diff -623390
write align 2048	pre 4.88ms	on 4.89ms	post 5.2ms	diff -155781
# ./flashbench -c 1 -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 4.68ms	on 9.06ms	post 5.14ms	diff 4.15ms
write align 4194304	pre 4.37ms	on 7.49ms	post 4.59ms	diff 3.01ms
write align 2097152	pre 23.7ms	on 1.9ms	post 14.8ms	diff -173218
write align 1048576	pre 14.8ms	on 19.9ms	post 4.75ms	diff 10.2ms
write align 524288	pre 20.2ms	on 24.9ms	post 10.7ms	diff 9.46ms
write align 262144	pre 20.2ms	on 3.01ms	post 20.1ms	diff -171062
write align 131072	pre 25.9ms	on 24.9ms	post 9.85ms	diff 7.06ms
write align 65536	pre 15.5ms	on 30.3ms	post 2.95ms	diff 21.1ms
write align 32768	pre 27.3ms	on 19.1ms	post 5.86ms	diff 2.5ms
write align 16384	pre 25.4ms	on 55.9ms	post 12.7ms	diff 36.9ms
write align 8192	pre 4.8ms	on 102ms	post 9.47ms	diff 94.8ms
write align 4096	pre 4.92ms	on 5.16ms	post 4.98ms	diff 207?s
write align 2048	pre 4.64ms	on 4.92ms	post 5.45ms	diff -121860
# ./flashbench -c 1 -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 15.8ms	on 9.39ms	post 4.68ms	diff -854295
write align 4194304	pre 4.76ms	on 7.54ms	post 3.82ms	diff 3.24ms
write align 2097152	pre 19.9ms	on 9.73ms	post 4.44ms	diff -244517
write align 1048576	pre 14.5ms	on 19.1ms	post 5.21ms	diff 9.23ms
write align 524288	pre 24.9ms	on 29ms	post 5.89ms	diff 13.6ms
write align 262144	pre 24.9ms	on 2.41ms	post 20.8ms	diff -204328
write align 131072	pre 25.6ms	on 30ms	post 4.84ms	diff 14.8ms
write align 65536	pre 26.4ms	on 24.4ms	post 6.16ms	diff 8.12ms
write align 32768	pre 15ms	on 30.6ms	post 15.4ms	diff 15.4ms
write align 16384	pre 16.1ms	on 45.4ms	post 16.5ms	diff 29.1ms
write align 8192	pre 5.88ms	on 107ms	post 5.45ms	diff 101ms
write align 4096	pre 5.17ms	on 5.78ms	post 4.83ms	diff 778?s
write align 2048	pre 3.99ms	on 5.27ms	post 3.97ms	diff 1.29ms
# ./flashbench -c 1 -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 16.1ms	on 8.37ms	post 5.44ms	diff -241222
write align 4194304	pre 4.07ms	on 7.27ms	post 3.89ms	diff 3.29ms
write align 2097152	pre 24.2ms	on 18.5ms	post 5.63ms	diff 3.59ms
write align 1048576	pre 4.08ms	on 18.9ms	post 5.46ms	diff 14.1ms
write align 524288	pre 25.1ms	on 28ms	post 14.6ms	diff 8.13ms
write align 262144	pre 15.8ms	on 30ms	post 5.4ms	diff 19.4ms
write align 131072	pre 24.7ms	on 30.8ms	post 4.43ms	diff 16.2ms
write align 65536	pre 5ms	on 40.5ms	post 5.95ms	diff 35.1ms
write align 32768	pre 24.7ms	on 30.6ms	post 4.92ms	diff 15.8ms
write align 16384	pre 25.2ms	on 132ms	post 10.2ms	diff 114ms
write align 8192	pre 7.64ms	on 111ms	post 9.18ms	diff 102ms
write align 4096	pre 5.11ms	on 3.92ms	post 5.4ms	diff -134159
write align 2048	pre 3.92ms	on 4.41ms	post 4.51ms	diff 196?s

> Also, does the same happen with other blocksizes, e.g. 4096 or 8192, passed
> to flashbench?
>

# echo 0 > /sys/block/mmcblk0/device/page_size
# ./flashbench -A -b 1024 /dev/block/mmcblk0p9
write align 8388608	pre 3.63ms	on 6.51ms	post 3.66ms	diff 2.86ms
write align 4194304	pre 3.61ms	on 6.51ms	post 3.62ms	diff 2.89ms
write align 2097152	pre 3.61ms	on 6.49ms	post 3.62ms	diff 2.87ms
write align 1048576	pre 3.64ms	on 6.55ms	post 3.62ms	diff 2.92ms
write align 524288	pre 3.64ms	on 6.57ms	post 3.66ms	diff 2.92ms
write align 262144	pre 3.44ms	on 6.45ms	post 3.66ms	diff 2.9ms
write align 131072	pre 3.64ms	on 6.56ms	post 3.67ms	diff 2.91ms
write align 65536	pre 3.33ms	on 6.57ms	post 3.65ms	diff 3.08ms
write align 32768	pre 3.68ms	on 6.6ms	post 3.7ms	diff 2.91ms
write align 16384	pre 3.64ms	on 97.6ms	post 3.26ms	diff 94.2ms
write align 8192	pre 3.49ms	on 115ms	post 3.62ms	diff 112ms
write align 4096	pre 3.91ms	on 3.91ms	post 3.9ms	diff 360ns
write align 2048	pre 3.92ms	on 3.92ms	post 3.92ms	diff -1374ns
# ./flashbench -A -b 2048 /dev/block/mmcblk0p9
write align 8388608	pre 3.76ms	on 7.23ms	post 4.18ms	diff 3.27ms
write align 4194304	pre 3.65ms	on 6.56ms	post 3.66ms	diff 2.9ms
write align 2097152	pre 3.9ms	on 6.99ms	post 3.67ms	diff 3.2ms
write align 1048576	pre 4.03ms	on 7.09ms	post 4.07ms	diff 3.04ms
write align 524288	pre 4.04ms	on 7.26ms	post 4.16ms	diff 3.16ms
write align 262144	pre 3.8ms	on 7.26ms	post 4.06ms	diff 3.33ms
write align 131072	pre 4.05ms	on 7.25ms	post 4.18ms	diff 3.14ms
write align 65536	pre 4.02ms	on 7.22ms	post 4.14ms	diff 3.14ms
write align 32768	pre 4ms	on 7.07ms	post 3.95ms	diff 3.1ms
write align 16384	pre 3.66ms	on 106ms	post 3.4ms	diff 102ms
write align 8192	pre 3.56ms	on 106ms	post 3.36ms	diff 103ms
write align 4096	pre 3.61ms	on 4.1ms	post 4.35ms	diff 117?s
# ./flashbench -A -b 4096 /dev/block/mmcblk0p9
write align 8388608	pre 3.64ms	on 6.95ms	post 3.96ms	diff 3.15ms
write align 4194304	pre 3.65ms	on 6.56ms	post 3.66ms	diff 2.9ms
write align 2097152	pre 3.89ms	on 6.79ms	post 3.66ms	diff 3.01ms
write align 1048576	pre 3.88ms	on 6.88ms	post 3.95ms	diff 2.97ms
write align 524288	pre 3.72ms	on 6.97ms	post 3.93ms	diff 3.15ms
write align 262144	pre 3.89ms	on 6.93ms	post 3.95ms	diff 3.01ms
write align 131072	pre 3.9ms	on 6.98ms	post 3.96ms	diff 3.05ms
write align 65536	pre 3.89ms	on 6.97ms	post 3.96ms	diff 3.04ms
write align 32768	pre 3.89ms	on 6.97ms	post 3.96ms	diff 3.04ms
write align 16384	pre 3.74ms	on 114ms	post 4.05ms	diff 110ms
write align 8192	pre 4.25ms	on 115ms	post 4.8ms	diff 110ms
# ./flashbench -A -b 8192 /dev/block/mmcblk0p9
write align 8388608	pre 3.84ms	on 7.53ms	post 4.29ms	diff 3.47ms
write align 4194304	pre 3.58ms	on 6.54ms	post 3.6ms	diff 2.95ms
write align 2097152	pre 4.12ms	on 7.27ms	post 3.87ms	diff 3.28ms
write align 1048576	pre 4.14ms	on 7.49ms	post 4.24ms	diff 3.3ms
write align 524288	pre 4.12ms	on 7.46ms	post 4.23ms	diff 3.29ms
write align 262144	pre 4.14ms	on 7.45ms	post 3.97ms	diff 3.4ms
write align 131072	pre 3.89ms	on 7.43ms	post 4.24ms	diff 3.37ms
write align 65536	pre 4.11ms	on 7.46ms	post 4.24ms	diff 3.29ms
write align 32768	pre 4.15ms	on 7.45ms	post 4.25ms	diff 3.25ms
write align 16384	pre 4.24ms	on 96.1ms	post 3.83ms	diff 92.1ms

The following I thought this was interesting. I did it to see the big
time go away, since it would end up being a 16K write straddling an 8K
boundary, but the pre and post results I don't understand at all.

# ./flashbench -A -b 16384  /dev/block/mmcblk0p9
write align 8388608	pre 121ms	on 7.76ms	post 116ms	diff -110845
write align 4194304	pre 129ms	on 7.57ms	post 115ms	diff -114863
write align 2097152	pre 121ms	on 7.78ms	post 123ms	diff -114318
write align 1048576	pre 131ms	on 7.74ms	post 106ms	diff -110856
write align 524288	pre 131ms	on 7.58ms	post 116ms	diff -115926
write align 262144	pre 131ms	on 7.55ms	post 115ms	diff -115591
write align 131072	pre 131ms	on 7.54ms	post 116ms	diff -115617
write align 65536	pre 131ms	on 7.54ms	post 115ms	diff -115579
write align 32768	pre 125ms	on 6.89ms	post 116ms	diff -113408
