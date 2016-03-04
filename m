From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 4 Mar 2016 12:26:13 +0100
Subject: DWord alignment on ARMv7
In-Reply-To: <56D96F44.6010905@pengutronix.de>
References: <56D8BA3F.7050508@pengutronix.de> <20160303235426.GA11237@arm.com>
 <CAKv+Gu8D37DgfbopvB1On_=fNqrBzmCmOCTotX2Lvv6NoSCtvw@mail.gmail.com>
 <20160304110210.GA19428@n2100.arm.linux.org.uk>
 <CAKv+Gu8b05BsNMPD2QNf9pLyRwSNGhc-5TVskwfudYuVqeCoAw@mail.gmail.com>
 <56D96F44.6010905@pengutronix.de>
Message-ID: <CAKv+Gu89CLyZjGTre3kJd_Gg+r2aE7tW5eME51rq_uH4gxew=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2016 at 12:19, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 03/04/2016 12:14 PM, Ard Biesheuvel wrote:
>> I wonder if we should simply apply something like the patch below
>> (untested): it depends on how many 32-bit architectures implement
>
> The "Last line effect" hit here.
>
>> double word load instructions, but for ones that don't, the patch
>> shouldn't change anything, nor should it change anything for 64-bit
>> architectures.
>
>> -------8<-----------
>> diff --git a/include/linux/unaligned/access_ok.h
>> b/include/linux/unaligned/access_ok.h
>> index 99c1b4d20b0f..019d0b7ea6a3 100644
>> --- a/include/linux/unaligned/access_ok.h
>> +++ b/include/linux/unaligned/access_ok.h
>> @@ -16,7 +16,11 @@ static inline u32 get_unaligned_le32(const void *p)
>>
>>  static inline u64 get_unaligned_le64(const void *p)
>>  {
>> -       return le64_to_cpup((__le64 *)p);
>> +       if (BITS_PER_LONG == 64)
>> +               return le64_to_cpup((__le64 *)p);
>> +       else
>> +               return ((u64)le32_to_cpup((__le32 *)p)) |
>> +                      ((u64)le32_to_cpup((__le32 *)p + 1) << 32);
>>  }
>>
>>  static inline u16 get_unaligned_be16(const void *p)
>> @@ -31,7 +35,11 @@ static inline u32 get_unaligned_be32(const void *p)
>>
>>  static inline u64 get_unaligned_be64(const void *p)
>>  {
>> -       return be64_to_cpup((__be64 *)p);
>> +       if (BITS_PER_LONG == 64)
>> +               return be64_to_cpup((__be64 *)p);
>> +       else
>> +               return ((u64)be32_to_cpup((__be32 *)p) << 32) |
>> +                      ((u64)be32_to_cpup((__be32 *)p + 1));
>>  }
>>
>>  static inline void put_unaligned_le16(u16 val, void *p)
>> @@ -46,7 +54,12 @@ static inline void put_unaligned_le32(u32 val, void *p)
>>
>>  static inline void put_unaligned_le64(u64 val, void *p)
>>  {
>> -       *((__le64 *)p) = cpu_to_le64(val);
>> +       if (BITS_PER_LONG == 64) {
>> +               *((__le64 *)p) = cpu_to_le64(val);
>> +       } else {
>> +               *((__le32 *)p) = cpu_to_le32(val);
>> +               *((__le32 *)p + 1) = cpu_to_le32(val >> 32);
>> +       }
>>  }
>>
>>  static inline void put_unaligned_be16(u16 val, void *p)
>> @@ -61,7 +74,12 @@ static inline void put_unaligned_be32(u32 val, void *p)
>>
>>  static inline void put_unaligned_be64(u64 val, void *p)
>>  {
>> -       *((__be64 *)p) = cpu_to_be64(val);
>> +       if (BITS_PER_LONG == 64) {
>> +               *((__be64 *)p) = cpu_to_be64(val);
>> +       } else {
>> +               *((__be32 *)p) = cpu_to_le32(val >> 32);
>                                           be32
>> +               *((__be32 *)p + 1) = cpu_to_le32(val);
>                                               be32
>

Ah yes, thanks for spotting that.
