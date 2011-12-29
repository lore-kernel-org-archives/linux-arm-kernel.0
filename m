From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Dec 2011 13:33:10 -0800
Subject: [PATCH v2] Input: keyboard - add device tree bindings for simple
 key matrixes
In-Reply-To: <4EFCD846.40901@gmail.com>
References: <1325112771-31941-1-git-send-email-olof@lixom.net>
 <1325184146-3527-1-git-send-email-olof@lixom.net>
 <4EFCD846.40901@gmail.com>
Message-ID: <CAOesGMh6dzy64H8Ex4u72uQt9NvnzVHuWxE5AwWL2ubxPm=zaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 1:14 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 12/29/2011 12:42 PM, Olof Johansson wrote:
>> This adds a simple device tree binding for simple key matrix data.
>>
>> Changes since v1:
>> ?* Removed samsung-style binding support
>> ?* Added linux,fn-keymap and linux,fn-key optional properties
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>> ?.../devicetree/bindings/input/matrix-keymap.txt ? ?| ? 25 ++++++
>> ?drivers/input/keyboard/Makefile ? ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?drivers/input/keyboard/keymap.c ? ? ? ? ? ? ? ? ? ?| ? 78 ++++++++++++++++++++
>> ?include/linux/input/matrix_keypad.h ? ? ? ? ? ? ? ?| ? 34 +++++----
>> ?4 files changed, 123 insertions(+), 15 deletions(-)
>> ?create mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.txt
>> ?create mode 100644 drivers/input/keyboard/keymap.c
>>
>> diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.txt b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> new file mode 100644
>> index 0000000..480ca46
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/matrix-keymap.txt
>> @@ -0,0 +1,25 @@
>> +For matrix keyboards there are two kinds of layout bindings using
>> +linux key codes.
>
> Need to update this.

Oops, yes.

>> +
>> +Required properties:
>> +- compatible: "matrix-keyboard-controller"
>> +- linux,keymap: an array of 3-cell entries containing the equivalent
>> + ?of the three separate properties above: row, column and linux
>> + ?key-code.
>> +
>
> How about just embedding the row/column information as the array
> position in the keymap? Then you only need 1 cell per key. Sparsely
> populated matrices are probably the exception. If more than 1/3 of the
> keys are present, you come out ahead in terms of data usage. You would
> need to specify the number of rows and columns, but that is probably
> easier than determining the max from the keymap.

Actually, in the case of the default layout for tegra-kbc, there are
109 keys defined in a 8*31 (248) matrix, and linux,fn-keymap is going
to be much sparser than that.

Instead, how about packing the row, column and index into one cell as
8, 8, 16 bits? That would be a win for both sparse and dense maps.

Number of rows and columns for the keyboard could be provided as
properties (num-rows, num-columns), it's something I've gone back and
forth in whether it should be in the generic binding or something that
is specific per keyboard vendor -- some of them are hardcoded so
providing properties might not add value.


-Olof
