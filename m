From: sjg@chromium.org (Simon Glass)
Date: Tue, 3 Jan 2012 08:22:21 -0800
Subject: [PATCH v3] Input: keyboard - add device tree bindings for simple
 key matrixes
In-Reply-To: <20120103154317.GA27061@quad.lixom.net>
References: <1325184146-3527-1-git-send-email-olof@lixom.net>
 <1325484557-27695-1-git-send-email-olof@lixom.net>
 <CAPnjgZ1ngJrqB5FgOZDmc-H9KBE0-W75rqTHEPX4D+q0FjYumg@mail.gmail.com>
 <20120103154317.GA27061@quad.lixom.net>
Message-ID: <CAPnjgZ3xN8+Ve28bcg1OQ4mv5rWvA-9ijP57UsuMQ5D1d=7Xxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Jan 3, 2012 at 7:43 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Mon, Jan 02, 2012 at 10:39:04AM -0800, Simon Glass wrote:
>> > diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> > new file mode 100644
>> > index 0000000..1db8e12
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> > @@ -0,0 +1,27 @@
>> > +A simple common binding for matrix-connected key boards. Currently targeted at
>> > +defining the keys in the scope of linux key codes since that is a stable and
>> > +standardized interface at this time.
>> > +
>> > +Required properties:
>> > +- compatible: "matrix-keyboard-controller"
>> > +- linux,keymap: an array of packed 1-cell entries containing the equivalent
>> > + ?of row, column and linux key-code. The 32-bit big endian cell is packed
>> > + ?as:
>> > + ? ? ? row << 24 | column << 16 | key-code
>>
>> This looks much better than the Samsung binding and the original 3-cell one.
>>
>> U-Boot Tegra (keyboard patch series) currently uses a 16x8 matrix, and
>> uses a single byte (the ASCII character) for a total of 128 bytes per
>> keymap. Since U-Boot does not have (or apparently want) the concept of
>> key codes or the added code and intermediate data this requires, the
>> binding presented here will not suit U-Boot so far.
>>
>> These rows and columns embedded in the cell make it more of a pain to
>> write the fdt description. If you just set up the cells in (column,
>> row) order and set the matrix size (rows, columns) then you end up
>> with 128 entries on Tegra. If you use uint16 then this could be 256
>> bytes instead of 512. The binding you present for Tegra would be 109 *
>> 4 = 436 bytes. However I take your point that Fn maps are much more
>> sparse, so overall this is likely to be similar (512 bytes for either
>> method once Fn mappings are taken into account).
>
> Looking at the keymap you posted, you define 62 keys and 16 function
> keys. So if that is all you care about on your particular keyboard,
> that means that the layout with the 1-cell format is 248 bytes for the
> base keymap, and 64 bytes for the fn-keymap. The benefit of using the
> row/column/keycode format is that the table is only as large as the
> number of keys you care about.

Yes - my point is that the number of entries in the 1-byte binding
(with no row, column embedded) is unlikely to be more than the next
power of 2. So by avoiding including 2 or 3 unnecessary bytes we can
actually get a size reduction in most cases. It is also easier to
enter IMO. Can the Linux key codes fit in 8 bits?

>
>> But going back to U-Boot, it does not have the intermediate table that
>> you malloc and decant into, it does not understand key codes so
>> doesn't know what to do when Shift is pressed, doesn't understand
>> languages, etc. In order to use these Linux bindings in U-Boot we
>> would need to add new input layer, extra decode code and intermediate
>> tables. I can almost hear the NAKs already (bear in mind fdt only went
>> into U-Boot in the December release and people are more sensitive to
>> code size / performance there than in Linux). I did ask about this on
>> this list a few weeks ago but no response yet.
>>
>> We could perhaps add an alternative direct ASCII binding like this
>> example (which would have to be in a separate node):
>
> You keep saying "direct ASCII", but your map contains non-ASCII
> characters. ASCII provides no way at all to specify things such as shift,
> or arrow keys, or other common new keys on keyboards. Instead you have had to
> make up an ad-hoc custom map that contains your own special codes for these
> keys.
>
> For example, for arrow keys you seem to overload the FS/GS/RS/US. I'm not
> saying we expect to need to use those ascii codes, but it does seem arbitrary
> to just grab them for arrow keys. So in essence you have come up with your own
> encoding of non-ASCII keys instead of reusing what is already available through
> the linux keycodes.
>
> Also, for example with return, does it encode as CR, LF or CR+LF? Etc.
>
> Doing a binding in pseudo-ASCII is just asking for extra complications, in my
> opinion. Over time that encoding is likely to swell to similar sizes anyway,
> but still be incompatible.

Yes it would be better to use one binding, just so long as it is
efficient and doesn't introduce a lot of new complexity in U-Boot
which is useful only with fdt.

>
>> ? ? ? ? ? ? ? ? /* Use a packed binding which doesn't include
>> row,column numbers in each cell */
>> ? ? ? ? ? ? ? ? packed-binding;
>> ? ? ? ? ? ? ? ? matrix-columns = <8>;
>> ? ? ? ? ? ? ? ? matrix-rows = <16>;
>> ? ? ? ? ? ? ? ? ascii-binding; ?/* ASCII characters instead of keycodes */
>> ? ? ? ? ? ? ? u-boot,keymap ?= /size/ 8 <00 ?00 ?'w' 's' 'a' 'z' 00 ?DE
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?00 ?00 ?00 ?00 ?00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?00 ?00 ?00 ?00 ?00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? '5' '4' 'r' 'e' 'f' 'd' 'x' 00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? '7' '6' 't' 'h' 'g' 'v' 'c' ' '
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? '9' '8' 'u' 'y' 'j' 'n' 'b' 5C
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? '-' '0' 'o' 'i' 'l' 'k' ',' 'm'
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?'=' ']' 0D ?00 ?00 ?00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?00 ?00 ?DF ?DF ?00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?00 ?00 ?00 ?DC ?00 ?DD
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?00 ?00 ?00 ?00 ?00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? '[' 'p' 27 ?';' '/' '.' 00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?08 ?'3' '2' 1E ?00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?7F ?00 ?00 ?00 ?1D ?1F ?1C
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?00 ?'q' 00 ?00 ?'1' 00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 1B ?'`' 00 ?09 ?00 ?00 ?00 ?00>;
>> ? ? ? ? ? ? ? u-boot,keymap-DF = /size/ 8 <00 ?00 ?'W' 'S' 'A' 'Z' 00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?00 ?00 ?00 ?00 ?00 ?00
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 00 ?00 ?00 ?00 ?00 ?00 ?00 ?00
>> ...
>>
>> The DC-DF codes codes denote Shift, Fn and Ctrl keys which would need
>> a separate keymap - although we could probably calculate the Ctrl one.
>
> I had included the row/column property in my binding for KEY_FN, but in
> hindsight it's probably just enough to decode that through the regular key
> layout, since there will be an entry for it there.

OK - just need some signal as to what key codes are modifiers.

>
>> From a point of view of efficiency, drivers can simply keep a pointer
>> to the appropriate property and read out the codes based on
>> (row,column) position.
>>
>> If we have something like this, then in order for the keyboard to work
>> in U-Boot, vendors would need to create a completely separate ASCII
>> mapping. Yes I agree this is a bit of a pain, but the above map is
>> fairly easy to type in, and quite compact.
>
> It doesn't make sense to come up with a fresh, brand new binding that
> requires anyone adding a new device to it to do extra work to do two
> redunant descriptions of the same device. We should be able to find common
> ground.

Yes I hope so.

>
> The KEY_* codes that are interesting all seem to be in the range of
> 0-83. In the u-boot case, that means the base KEY*-to-ascii table would
> be 83 bytes.
>
> That means that the memory consumption for your case above would be
> 4*62+4*16=312 bytes for the base+fn table, and then 3*83 = 249 bytes
> for the KEY*-to-ASCII tables for regular/shift/ctrl, for a total of
> 561 bytes. I'm sure there will be a few special cases in the code just
> like you have now for arrow keys, etc, but they don't have to be in the
> 83-byte table.
>
> Sure, that is somewhat more than your 4*128 byte tables, but it is also
> a much more flexible binding that is less likely to hit limitations down
> the road.

Thanks for looking at this. We still have the need of the intermediate
table but since that is in BSS I don't think it is a problem.

>
>> Given the push-back on the U-Boot list from Linux people about my
>> bindings, I would like to work out the U-Boot side in this thread if
>> possible, since it seems to be dependent on what Linux does. But I
>> hope what is created is efficient enough not to bloat U-Boot or
>> require an new input layer to be added just to use fdt.
>
> I think it's a great idea to use a common binding, since there will just be
> wasted effort for vendors to have to create two maps and keep them in sync.

I will have a look at this approach and see what the impact is, and
reply on this thread.

Regards,
Simon

>
>
> -Olof
