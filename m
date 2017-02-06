From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 02:25:51 +0800
Subject: [hisi:topic-lpc-4.10-libio 136/148] lib/libio.c:27:21: error:
 dereferencing pointer to incomplete type
Message-ID: <201702070249.zQECfema%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

First bad commit (maybe != root cause):

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: 1138304d3967f65dac8be95ce39f9abffc5f1f65 [136/148] libio: create from extio
config: x86_64-randconfig-i0-201706 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 1138304d3967f65dac8be95ce39f9abffc5f1f65
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the hisi/topic-lpc-4.10-libio HEAD 06443d85dc35b64a704f7be84cc538281a1598f4 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   lib/libio.c:24:28: warning: 'struct extio_node' declared inside parameter list
    void register_extio(struct extio_node *node)
                               ^
>> lib/libio.c:24:28: warning: its scope is only this definition or declaration, which is probably not what you want
   lib/libio.c: In function 'register_extio':
>> lib/libio.c:27:21: error: dereferencing pointer to incomplete type
     list_add_tail(&node->list, &extio_dev_list);
                        ^
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from lib/libio.c:18:
   lib/libio.c: In function 'find_extio_token':
   include/linux/list.h:463:43: error: dereferencing pointer to incomplete type
     for (pos = list_first_entry(head, typeof(*pos), member); \
                                              ^
   include/linux/kernel.h:850:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^
   lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(extio_entry, &extio_dev_list, list) {
     ^
   include/linux/kernel.h:850:48: warning: initialization from incompatible pointer type
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^
   lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(extio_entry, &extio_dev_list, list) {
     ^
   include/linux/list.h:463:43: error: dereferencing pointer to incomplete type
     for (pos = list_first_entry(head, typeof(*pos), member); \
                                              ^
   include/linux/kernel.h:851:3: note: in definition of macro 'container_of'
     (type *)( (char *)__mptr - offsetof(type,member) );})
      ^
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^
   lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(extio_entry, &extio_dev_list, list) {
     ^
   In file included from include/linux/compiler.h:58:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/io.h:21,
                    from lib/libio.c:18:
   include/linux/list.h:463:43: error: dereferencing pointer to incomplete type
     for (pos = list_first_entry(head, typeof(*pos), member); \
                                              ^
   include/linux/compiler-gcc.h:159:21: note: in definition of macro '__compiler_offsetof'
     __builtin_offsetof(a, b)
                        ^
   include/linux/kernel.h:851:29: note: in expansion of macro 'offsetof'
     (type *)( (char *)__mptr - offsetof(type,member) );})
                                ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^
   lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(extio_entry, &extio_dev_list, list) {
     ^
   In file included from include/linux/preempt.h:10:0,
                    from include/linux/spinlock.h:50,
                    from lib/libio.c:19:
   include/linux/list.h:464:11: error: dereferencing pointer to incomplete type
          &pos->member != (head);     \
              ^
   lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(extio_entry, &extio_dev_list, list) {
     ^
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from lib/libio.c:18:
   include/linux/list.h:409:40: error: dereferencing pointer to incomplete type
     list_entry((pos)->member.next, typeof(*(pos)), member)
                                           ^
   include/linux/kernel.h:850:18: note: in definition of macro 'container_of'
--
     list_for_each_entry(entry, &extio_dev_list, list) {
     ^
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from lib/libio.c:18:
   include/linux/list.h:409:40: error: dereferencing pointer to incomplete type
     list_entry((pos)->member.next, typeof(*(pos)), member)
                                           ^
   include/linux/kernel.h:850:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^
   include/linux/list.h:409:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^
   include/linux/list.h:465:13: note: in expansion of macro 'list_next_entry'
          pos = list_next_entry(pos, member))
                ^
   lib/libio.c:66:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &extio_dev_list, list) {
     ^
   include/linux/list.h:409:18: error: dereferencing pointer to incomplete type
     list_entry((pos)->member.next, typeof(*(pos)), member)
                     ^
   include/linux/kernel.h:850:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^
   include/linux/list.h:409:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^
   include/linux/list.h:465:13: note: in expansion of macro 'list_next_entry'
          pos = list_next_entry(pos, member))
                ^
   lib/libio.c:66:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &extio_dev_list, list) {
     ^
   include/linux/list.h:409:40: error: dereferencing pointer to incomplete type
     list_entry((pos)->member.next, typeof(*(pos)), member)
                                           ^
   include/linux/kernel.h:851:3: note: in definition of macro 'container_of'
     (type *)( (char *)__mptr - offsetof(type,member) );})
      ^
   include/linux/list.h:409:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^
   include/linux/list.h:465:13: note: in expansion of macro 'list_next_entry'
          pos = list_next_entry(pos, member))
                ^
   lib/libio.c:66:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &extio_dev_list, list) {
     ^
   In file included from include/linux/compiler.h:58:0,
                    from include/uapi/linux/stddef.h:1,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/io.h:21,
                    from lib/libio.c:18:
   include/linux/list.h:409:40: error: dereferencing pointer to incomplete type
     list_entry((pos)->member.next, typeof(*(pos)), member)
                                           ^
   include/linux/compiler-gcc.h:159:21: note: in definition of macro '__compiler_offsetof'
     __builtin_offsetof(a, b)
                        ^
   include/linux/kernel.h:851:29: note: in expansion of macro 'offsetof'
     (type *)( (char *)__mptr - offsetof(type,member) );})
                                ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^
   include/linux/list.h:409:2: note: in expansion of macro 'list_entry'
     list_entry((pos)->member.next, typeof(*(pos)), member)
     ^
   include/linux/list.h:465:13: note: in expansion of macro 'list_next_entry'
          pos = list_next_entry(pos, member))
                ^
   lib/libio.c:66:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &extio_dev_list, list) {
     ^
   lib/libio.c:67:12: error: dereferencing pointer to incomplete type
      if (entry->fwnode == node &&
               ^
   lib/libio.c:68:21: error: dereferencing pointer to incomplete type
       bus_addr >= entry->bus_start &&
                        ^
   lib/libio.c:69:20: error: dereferencing pointer to incomplete type
       bus_addr - entry->bus_start < entry->range_size)
                       ^
   lib/libio.c:69:39: error: dereferencing pointer to incomplete type
       bus_addr - entry->bus_start < entry->range_size)
                                          ^
   lib/libio.c:70:19: error: dereferencing pointer to incomplete type
       port_id = entry->io_start + bus_addr -
                      ^
   lib/libio.c:71:11: error: dereferencing pointer to incomplete type
         entry->bus_start;
              ^
   lib/libio.c: At top level:
>> lib/libio.c:78:57: warning: 'struct acpi_resource' declared inside parameter list
    static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
                                                            ^
   lib/libio.c: In function 'acpi_extio_supported_resource':
   lib/libio.c:80:13: error: dereferencing pointer to incomplete type
     switch (res->type) {
                ^
   lib/libio.c:81:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS16' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS16:
          ^
   lib/libio.c:81:7: note: each undeclared identifier is reported only once for each function it appears in
   lib/libio.c:82:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS32' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS32:
          ^
   lib/libio.c:83:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS64' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS64:
          ^
   lib/libio.c: At top level:
   lib/libio.c:89:8: error: unknown type name 'acpi_status'
    static acpi_status acpi_count_extiores(struct acpi_resource *res,
           ^
   lib/libio.c:90:9: warning: 'struct acpi_resource' declared inside parameter list
            void *data)
            ^
   lib/libio.c: In function 'acpi_count_extiores':
   lib/libio.c:94:36: warning: passing argument 1 of 'acpi_extio_supported_resource' from incompatible pointer type
     if (acpi_extio_supported_resource(res) &&
                                       ^
   lib/libio.c:78:20: note: expected 'struct acpi_resource *' but argument is of type 'struct acpi_resource *'
    static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
                       ^
   lib/libio.c:95:3: error: implicit declaration of function 'acpi_dev_filter_resource_type' [-Werror=implicit-function-declaration]
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO))
      ^
>> lib/libio.c:95:39: error: 'IORESOURCE_IO' undeclared (first use in this function)
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO))
                                          ^
   lib/libio.c:98:9: error: 'AE_OK' undeclared (first use in this function)
     return AE_OK;
            ^
   lib/libio.c: At top level:
   lib/libio.c:101:8: error: unknown type name 'acpi_status'
    static acpi_status acpi_read_one_extiores(struct acpi_resource *res,
           ^
   lib/libio.c:102:3: warning: 'struct acpi_resource' declared inside parameter list
      void *data)
      ^
   lib/libio.c: In function 'acpi_read_one_extiores':
   lib/libio.c:106:36: warning: passing argument 1 of 'acpi_extio_supported_resource' from incompatible pointer type
     if (acpi_extio_supported_resource(res) &&
                                       ^
   lib/libio.c:78:20: note: expected 'struct acpi_resource *' but argument is of type 'struct acpi_resource *'
    static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
                       ^
   lib/libio.c:107:39: error: 'IORESOURCE_IO' undeclared (first use in this function)
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
                                          ^
   lib/libio.c:108:35: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
      memcpy((*resource), res, sizeof(struct acpi_resource));
                                      ^
   lib/libio.c:109:14: error: dereferencing pointer to incomplete type
      (*resource)->length = sizeof(struct acpi_resource);
                 ^
   lib/libio.c:109:32: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
      (*resource)->length = sizeof(struct acpi_resource);
                                   ^
   lib/libio.c:110:14: error: dereferencing pointer to incomplete type
      (*resource)->type = res->type;
                 ^
   lib/libio.c:110:26: error: dereferencing pointer to incomplete type
      (*resource)->type = res->type;
                             ^
>> lib/libio.c:111:14: error: increment of pointer to unknown structure
      (*resource)++;
                 ^
>> lib/libio.c:111:3: error: arithmetic on pointer to an incomplete type
      (*resource)++;
      ^
   lib/libio.c:114:9: error: 'AE_OK' undeclared (first use in this function)
     return AE_OK;
            ^
   lib/libio.c: At top level:
   lib/libio.c:117:8: error: unknown type name 'acpi_status'
    static acpi_status
           ^
>> lib/libio.c:119:11: warning: 'struct acpi_buffer' declared inside parameter list
       struct acpi_buffer *buffer)
              ^
>> lib/libio.c:119:11: warning: 'struct acpi_device' declared inside parameter list
   lib/libio.c: In function 'acpi_build_extiores_template':
   lib/libio.c:121:2: error: unknown type name 'acpi_handle'
     acpi_handle handle = adev->handle;
     ^
   lib/libio.c:121:27: error: dereferencing pointer to incomplete type
     acpi_handle handle = adev->handle;
                              ^
   lib/libio.c:123:2: error: unknown type name 'acpi_status'
     acpi_status status;
     ^
   lib/libio.c:126:2: error: implicit declaration of function 'acpi_walk_resources' [-Werror=implicit-function-declaration]
     status = acpi_walk_resources(handle, METHOD_NAME__PRS,
     ^
   lib/libio.c:126:39: error: 'METHOD_NAME__PRS' undeclared (first use in this function)
     status = acpi_walk_resources(handle, METHOD_NAME__PRS,
                                          ^
   lib/libio.c:128:2: error: implicit declaration of function 'ACPI_FAILURE' [-Werror=implicit-function-declaration]
     if (ACPI_FAILURE(status) || !res_cnt) {
     ^
   lib/libio.c:129:3: error: implicit declaration of function 'dev_err' [-Werror=implicit-function-declaration]
      dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
      ^
   lib/libio.c:129:16: error: dereferencing pointer to incomplete type
      dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
                   ^
   lib/libio.c:133:8: error: dereferencing pointer to incomplete type
     buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
           ^
   lib/libio.c:133:26: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
     buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
                             ^
   lib/libio.c:134:8: error: dereferencing pointer to incomplete type
     buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
           ^
   lib/libio.c:134:2: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
     buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
     ^
   lib/libio.c:134:34: error: dereferencing pointer to incomplete type
     buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
                                     ^
   lib/libio.c:134:48: error: 'GFP_KERNEL' undeclared (first use in this function)
     buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
                                                   ^
   lib/libio.c:135:13: error: dereferencing pointer to incomplete type
     if (!buffer->pointer)
                ^
   lib/libio.c:138:43: error: dereferencing pointer to incomplete type
     resource = (struct acpi_resource *)buffer->pointer;
                                              ^
   lib/libio.c:142:3: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
      kfree(buffer->pointer);
      ^
   lib/libio.c:142:15: error: dereferencing pointer to incomplete type
      kfree(buffer->pointer);
                  ^
   lib/libio.c:143:16: error: dereferencing pointer to incomplete type
      dev_err(&adev->dev, "can't evaluate _PRS: %d\n", status);
                   ^
   lib/libio.c:147:10: error: dereferencing pointer to incomplete type
     resource->type = ACPI_RESOURCE_TYPE_END_TAG;
             ^
   lib/libio.c:147:19: error: 'ACPI_RESOURCE_TYPE_END_TAG' undeclared (first use in this function)
     resource->type = ACPI_RESOURCE_TYPE_END_TAG;
                      ^
   lib/libio.c:148:10: error: dereferencing pointer to incomplete type
     resource->length = sizeof(struct acpi_resource);
             ^
   lib/libio.c:148:28: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
     resource->length = sizeof(struct acpi_resource);
                               ^
   lib/libio.c: At top level:
   lib/libio.c:154:36: warning: 'struct acpi_buffer' declared inside parameter list
      struct acpi_device *host, struct acpi_buffer *buffer)
                                       ^
   lib/libio.c:154:36: warning: 'struct acpi_device' declared inside parameter list
   lib/libio.c: In function 'acpi_translate_extiores':
   lib/libio.c:156:23: error: dereferencing pointer to incomplete type
     int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
                          ^
   lib/libio.c:156:46: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
     int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
                                                 ^
   lib/libio.c:157:41: error: dereferencing pointer to incomplete type
     struct acpi_resource *resource = buffer->pointer;
                                            ^
   lib/libio.c:158:33: error: storage size of 'addr' isn't known
     struct acpi_resource_address64 addr;
                                    ^
   lib/libio.c:160:28: error: dereferencing pointer to incomplete type
     struct device *dev = &adev->dev;
                               ^
   lib/libio.c:165:21: error: dereferencing pointer to incomplete type
       res_cnt, resource->type);
                        ^
   lib/libio.c:169:2: error: implicit declaration of function 'acpi_resource_to_address64' [-Werror=implicit-function-declaration]
     if (ACPI_FAILURE(acpi_resource_to_address64(resource, &addr))) {
     ^
   lib/libio.c:171:12: error: dereferencing pointer to incomplete type
       resource->type);
               ^

vim +27 lib/libio.c

14c67d09 lib/extio.c zhichang.yuan 2017-01-23   18  #include <linux/io.h>
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   19  #include <linux/spinlock.h>
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   20  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   21  static LIST_HEAD(extio_dev_list);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   22  static DEFINE_RWLOCK(extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   23  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23  @24  void register_extio(struct extio_node *node)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   25  {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   26  	write_lock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23  @27  	list_add_tail(&node->list, &extio_dev_list);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   28  	write_unlock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   29  }
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   30  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   31  static struct extio_node *find_extio_token(unsigned long addr)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   32  {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   33  	struct extio_node *extio_entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   34  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   35  	read_lock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   36  	list_for_each_entry(extio_entry, &extio_dev_list, list) {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   37  		if ((addr < extio_entry->io_start + extio_entry->range_size) &&
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   38  			(addr >= extio_entry->io_start))
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   39  			break;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   40  	}
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   41  	read_unlock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   42  	return (&extio_entry->list == &extio_dev_list) ? NULL : extio_entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   43  }
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   44  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   45  struct extio_node *extio_find_node(struct fwnode_handle *node)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   46  {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   47  	struct extio_node *entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   48  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   49  	read_lock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   50  	list_for_each_entry(entry, &extio_dev_list, list) {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   51  		if (entry->fwnode == node)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   52  			break;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   53  	}
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   54  	read_unlock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   55  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   56  	return (&entry->list == &extio_dev_list) ? NULL : entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   57  }
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   58  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   59  unsigned long extio_translate(struct fwnode_handle *node,
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   60  		unsigned long bus_addr)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   61  {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   62  	struct extio_node *entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   63  	unsigned long port_id = -1;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   64  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   65  	read_lock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   66  	list_for_each_entry(entry, &extio_dev_list, list) {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   67  		if (entry->fwnode == node &&
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   68  			bus_addr >= entry->bus_start &&
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   69  			bus_addr - entry->bus_start < entry->range_size)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23  @70  			port_id = entry->io_start + bus_addr -
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   71  					entry->bus_start;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   72  	}
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   73  	read_unlock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   74  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   75  	return port_id;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   76  }
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   77  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @78  static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   79  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   80  	switch (res->type) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   81  	case ACPI_RESOURCE_TYPE_ADDRESS16:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   82  	case ACPI_RESOURCE_TYPE_ADDRESS32:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   83  	case ACPI_RESOURCE_TYPE_ADDRESS64:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   84  		return true;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   85  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   86  	return false;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   87  }
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   88  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   89  static acpi_status acpi_count_extiores(struct acpi_resource *res,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   90  					   void *data)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   91  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   92  	int *res_cnt = data;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   93  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @94  	if (acpi_extio_supported_resource(res) &&
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @95  		!acpi_dev_filter_resource_type(res, IORESOURCE_IO))
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   96  		(*res_cnt)++;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   97  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   98  	return AE_OK;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   99  }
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  100  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  101  static acpi_status acpi_read_one_extiores(struct acpi_resource *res,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  102  		void *data)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  103  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  104  	struct acpi_resource **resource = data;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  105  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  106  	if (acpi_extio_supported_resource(res) &&
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  107  		!acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  108  		memcpy((*resource), res, sizeof(struct acpi_resource));
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @109  		(*resource)->length = sizeof(struct acpi_resource);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @110  		(*resource)->type = res->type;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @111  		(*resource)++;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  112  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  113  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @114  	return AE_OK;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  115  }
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  116  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @117  static acpi_status
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  118  acpi_build_extiores_template(struct acpi_device *adev,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @119  			struct acpi_buffer *buffer)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  120  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  121  	acpi_handle handle = adev->handle;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  122  	struct acpi_resource *resource;

:::::: The code at line 27 was first introduced by commit
:::::: 14c67d09a6034fd1fbce0bb1e31baf312abde981 LIB: Indirect ISA/LPC port IO introduced

:::::: TO: zhichang.yuan <yuanzhichang@hisilicon.com>
:::::: CC: zhichang.yuan <yuanzhichang@hisilicon.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26858 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/adb7f8db/attachment-0001.gz>
